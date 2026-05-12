import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:fork_mate/models/customer/location_model.dart';
import 'package:fork_mate/models/customer/order_model.dart';
import 'package:fork_mate/models/customer/points_model.dart';
import 'package:fork_mate/services/customer/notifications_services.dart';
import 'package:fork_mate/view/floating_bottom_bar/floating_bottom_bar_controller.dart';
import 'package:get/get.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/show_loading_dialog.dart';
import 'package:fork_mate/models/customer/coupon_model.dart';
import 'package:fork_mate/models/customer/discount_code_model.dart';
import 'package:fork_mate/services/customer/customer_data_services.dart';
import 'package:fork_mate/services/customer/order_details_services.dart';

class OrderDetailsController extends GetxController {
  late final OrderModel orderModel;
  late final int orderId;
  late final double orderPrice;

  int hasRunningOrdersRequestCount = 0;
  RxDouble finalPrice = 0.0.obs;
  RxBool isPayed = false.obs;

  RxnString paymentMethod = RxnString(null);
  RxnString deliveryMethod = RxnString(null);
  Rxn<LocationsModel> locationDetails = Rxn(null);
  Rxn<List<CouponModel>> discountCoupons = Rxn(null);
  Rxn<List<CouponModel>> freeDeliveryCoupon = Rxn(null);
  Rxn<DiscountCodeModel> discountCode = Rxn(null);
  //----
  Rx<Map<int, double>> usedCoupons = Rx({});
  Rx<Map<String, double>> usedCode = Rx({});
  RxnInt usedFreeDeliveryCoupon = RxnInt(null);

  Future<OrderDetailsController> create(
    OrderModel orderModel,
    int orderId,
  ) async {
    this.orderModel = orderModel;
    this.orderId = orderId;
    orderPrice = orderModel.orderPrice();
    calculateFinalPrice();
    return this;
  }

  void order() async {
    bool detailsComplete = checkComplete();
    if (!detailsComplete) return;

    showLoadingDialog();
    if (await checkIfHasRunningOrder()) {
      Get.back();
      bool confirm = await confirmationDialog(
        message:
            'you already have an active order. would you like to start a new one?',
      );
      if (!confirm) {
        return;
      }
    } else {
      Get.back();
    }
    Map finalOrder = {
      'order': orderModel.orderDTO(),
      'coupons': usedCoupons.value.keys.toList(),
      'discount_code': usedCode.value.keys.toList(),
      'free_delivery_coupon': usedFreeDeliveryCoupon.value,
      'location': locationDetails.toJson(),
      'payment': {'payment_method': paymentMethod.value, 'details': null},
    };
    try {
      bool success = await OrdersDetailsServices.sendOrder(finalOrder);
      if (success) {
        Get.until((route) => route.isFirst);
        Get.find<FloatingBottomBarController>().setPage(Pages.cart);
        CartController controller = Get.find<CartController>();
        controller.setType(orderStatus[1]);
        controller.removeOrderFromCart(orderId);
      }
    } catch (_) {
      createSnackBar(networkError: true);
    }
  }

  Future<bool> checkIfHasRunningOrder() async {
    try {
      bool hasRunningOrders = await NotificationsServices.hasRunningOrders();
      return hasRunningOrders;
    } catch (_) {
      if (hasRunningOrdersRequestCount < 4) {
        hasRunningOrdersRequestCount++;
        return checkIfHasRunningOrder();
      } else {
        hasRunningOrdersRequestCount = 0;
        return false;
      }
    }
  }

  void setPaymentMethod(String? method) {
    paymentMethod.value = method;
    if (method == pointsMethod) {
      isPayed.value = true;
    } else {
      isPayed.value = false;
    }
    calculateFinalPrice();
  }

  void setDeliveryMethod(String? method, LocationsModel? location) {
    if (location == null || method == null) {
      deliveryMethod.value = null;
      locationDetails.value = null;
    } else {
      deliveryMethod.value = method;
      locationDetails.value = location;
      if (deliveryMethod.value == restaurantPickup &&
          usedFreeDeliveryCoupon.value != null) {
        usedFreeDeliveryCoupon.value = null;
        createSnackBar(
          message:
              'you cannot use a free delivery coupon for restaurant pick-up orders'
                  .tr,
          milliSecondDuration: 3000,
        );
      }
    }
    calculateFinalPrice();
  }

  void payByPoints() async {
    showWaitingPopScope(message: "calculating your point");
    try {
      PointsModel points = await CustomerDataServices.fetchPoints();
      final myPointsValue = points.pointValue();
      final orderPrice = calculateFinalPrice();
      if (myPointsValue >= orderPrice) {
        Get.back();
        createSnackBar(
          message: 'your points will be applied when you place the order',
          milliSecondDuration: 1800,
        );
        setPaymentMethod(pointsMethod);
        return;
      } else {
        setPaymentMethod(null);
        Get.back();
        createSnackBar(
          message: 'sorry, you have only  @points  points worth  @value  S.P'
              .trParams({
                'points': points.pointsCount.toStringAsFixed(2),
                'value': formatPrice(points.pointValue()),
              }),
          milliSecondDuration: 2000,
        );
        return;
      }
    } catch (_) {
      setPaymentMethod(null);
      Get.back();
      createSnackBar(networkError: true);
      return;
    } finally {
      calculateFinalPrice();
    }
  }

  double calculateFinalPrice() {
    if (isPayed.value) {
      if (usedFreeDeliveryCoupon.value == null) {
        return finalPrice.value = locationDetails.value?.price ?? 0;
      } else {
        return finalPrice.value = 0.0;
      }
    }
    double price = orderModel.orderPrice();
    for (var discount in usedCoupons.value.values) {
      price -= (price * discount) / 100;
    }
    for (var discount in usedCode.value.values) {
      price -= (price * discount) / 100;
    }
    if (locationDetails.value != null && usedFreeDeliveryCoupon.value == null) {
      price += locationDetails.value!.price;
    }

    finalPrice.value = price;

    return price;
  }

  Future<void> getCoupons() async {
    discountCouponCounterDisposer();
    discountCoupons.value = null;
    usedCoupons.value = {};

    showLoadingDialog();
    try {
      List<CouponModel> activator = await CustomerDataServices.fetchCoupons();
      Get.back();
      for (var element in activator) {
        final timer = CountdownController(
          timeString: element.remainingTime,
          tag: element.tag,
        );
        timer.callBackMap[element.tag] = () {
          discountCoupons.value?.remove(element);
          usedCoupons.value.remove(element.id);
          calculateFinalPrice();
          discountCode.refresh();
          usedCoupons.refresh();
        };
        Get.put(timer, tag: timer.tag);
      }
      discountCoupons.value = activator;
      if (discountCoupons.value!.isEmpty) {
        createSnackBar(message: "you don't have any coupons");
      }
    } catch (_) {
      Get.back();
      createSnackBar(networkError: true);
      return;
    }
  }

  Future<void> getFreeDeliveryCoupon() async {
    freeDeliveryCouponCounterDisposer();
    freeDeliveryCoupon.value = null;
    usedFreeDeliveryCoupon.value = null;
    showLoadingDialog();
    try {
      List<CouponModel> activator =
          await CustomerDataServices.fetchFreeDeliveryCoupons();
      Get.back();
      for (var element in activator) {
        final timer = CountdownController(
          timeString: element.remainingTime,
          tag: element.tag,
        );
        timer.callBackMap[element.tag] = () {
          freeDeliveryCoupon.value?.remove(element);
          usedFreeDeliveryCoupon.value = null;
          usedFreeDeliveryCoupon.refresh();
        };
        Get.put(timer, tag: timer.tag);
      }
      freeDeliveryCoupon.value = activator;
      if (freeDeliveryCoupon.value!.isEmpty) {
        createSnackBar(message: "you don't have any free delivery coupons");
      }
    } catch (_) {
      Get.back();
      createSnackBar(networkError: true);
    }
  }

  Future<void> useDiscountCode(String code) async {
    showLoadingDialog();
    try {
      discountCode.value = await OrdersDetailsServices.useDiscountCode(code);
      Get.back();
      if (discountCode.value!.valid) {
        usedCode.value[discountCode.value!.code] = discountCode.value!.discount;
        usedCode.refresh();
        calculateFinalPrice();
        pointDetector();
      } else {
        createSnackBar(message: discountCode.value!.message);
      }
      return;
    } catch (_) {
      Get.back();
      createSnackBar(networkError: true);
    }
  }

  void pointDetector() {
    if (paymentMethod.value == pointsMethod) {
      createSnackBar(
        message:
            'final price has been updated. please recalculate your points'.tr,
        milliSecondDuration: 1500,
      );
      setPaymentMethod(null);
    }
  }

  bool checkComplete() {
    if (paymentMethod.value == null && !orderModel.isGiftsOnly()) {
      createSnackBar(
        message: 'please select a payment method',
        milliSecondDuration: 900,
      );
      return false;
    }
    if (deliveryMethod.value == null) {
      createSnackBar(
        message: 'please select a delivery method',
        milliSecondDuration: 900,
      );
      return false;
    }
    return true;
  }

  void discountCouponCounterDisposer() {
    if (discountCoupons.value == null) return;
    for (var element in discountCoupons.value!) {
      Get.delete<CountdownController>(tag: element.tag);
    }
  }

  void freeDeliveryCouponCounterDisposer() {
    if (freeDeliveryCoupon.value == null) return;
    for (var element in freeDeliveryCoupon.value!) {
      Get.delete<CountdownController>(tag: element.tag);
    }
  }

  bool isCouponUsed(CouponModel coupon) {
    if (coupon.type == 'discount_coupon') {
      return usedCoupons.value.containsKey(coupon.id);
    } else {
      return coupon.id == usedFreeDeliveryCoupon.value;
    }
  }

  void useCoupon(CouponModel coupon) {
    if (coupon.type == 'discount_coupon') {
      if (usedCoupons.value.containsKey(coupon.id)) {
        usedCoupons.value.remove(coupon.id);
        usedCoupons.refresh();
      } else {
        usedCoupons.value[coupon.id] = coupon.discount;
        usedCoupons.refresh();
      }
      pointDetector();
    } else {
      if (usedFreeDeliveryCoupon.value == coupon.id) {
        usedFreeDeliveryCoupon.value = null;
      } else {
        if (deliveryMethod.value == restaurantPickup) {
          createSnackBar(
            message:
                'you cannot use a free delivery coupon for restaurant pick-up orders'
                    .tr,
            milliSecondDuration: 3000,
          );
        } else {
          usedFreeDeliveryCoupon.value = coupon.id;
        }
      }
    }
    calculateFinalPrice();
  }
}
