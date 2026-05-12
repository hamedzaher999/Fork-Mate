import 'package:flutter/material.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/models/customer/customer_gift_model.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/models/customer/offer_model.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:fork_mate/services/customer/order_details_services.dart';
import 'package:get/get.dart';
import 'package:fork_mate/functions/get_available_key.dart';
import 'package:fork_mate/models/customer/order_model.dart';

class CartController extends GetxController with WidgetsBindingObserver {
  RxBool runningOrdersNetworkError = false.obs;
  RxBool canceledOrdersNetworkError = false.obs;
  //--
  RxBool isRunningOrdersFetching = false.obs;
  RxBool isCanceledOrdersFetching = false.obs;

  Map<int, OrderModel> cart = {};
  Rxn<List<RunningOrderModel>> inProgressOrder = Rxn(null);
  Rxn<List<RunningOrderModel>> canceledOrder = Rxn(null);
  int? currentOrder;
  String type = orderStatus[0];

  Future<void> refreshPage() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (type == 'In Progress') {
      getInProgressOrders();
    } else if (type == 'Canceled') {
      getCanceledOrders();
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      final response = await OrdersDetailsServices.cancelOrder(orderId);
      if (response['status'] == 'success') {
        Get.back();
        setType(orderStatus[1]);
      }
      createSnackBar(message: response['message']);
    } catch (_) {
      createSnackBar(networkError: true);
    }
  }

  Future<void> getInProgressOrders() async {
    runningOrdersNetworkError.value = false;
    if (!isRunningOrdersFetching.value) {
      inProgressOrder.value = null;
      isRunningOrdersFetching.value = true;
      try {
        List<RunningOrderModel> orders =
            await OrdersDetailsServices.fetchRunningOrders();
        inProgressOrder.value = orders;
      } catch (_) {
        runningOrdersNetworkError.value = true;
      } finally {
        isRunningOrdersFetching.value = false;
      }
    }
  }

  Future<void> getCanceledOrders() async {
    canceledOrdersNetworkError.value = false;
    if (!isCanceledOrdersFetching.value) {
      canceledOrder.value = null;
      isCanceledOrdersFetching.value = true;
      try {
        canceledOrder.value = await OrdersDetailsServices.fetchRunningOrders(
          canceled: true,
        );
      } catch (_) {
        canceledOrdersNetworkError.value = true;
      } finally {
        isCanceledOrdersFetching.value = false;
      }
    }
  }

  Future<bool> addItemToTheCurrentOrder(ItemModel item) async {
    if (currentOrder == null || cart.isEmpty) createNewOrder();
    bool add = await cart[currentOrder]!.addItem(item);
    return add;
  }

  Future<bool> addOfferToTheCurrentOrder(OfferModel offer) async {
    if (currentOrder == null || cart.isEmpty) createNewOrder();
    bool add = await cart[currentOrder]!.addOffer(offer);
    return add;
  }

  void addGiftToTheCurrentOrder(CustomerGiftModel gift) async {
    if (currentOrder == null || cart.isEmpty) createNewOrder();
    cart[currentOrder]!.addGift(gift);
  }

  void removeOrderFromCart(int? orderId) {
    cart.remove(orderId);
    setCurrent();
    update();
  }

  void setType(String type) {
    this.type = type;
    if (type == 'In Progress') {
      getInProgressOrders();
    } else if (type == 'Canceled') {
      getCanceledOrders();
    }
    update();
  }

  void setCurrent() {
    if (cart.isNotEmpty) {
      currentOrder = cart.keys.last;
    } else {
      currentOrder = null;
    }
  }

  void createNewOrder() {
    int key = getNextAvailableKey(cart.keys.toList());
    cart[key] = OrderModel();
    currentOrder = key;
  }

  void removeDiscountFromItem(int itemId) {
    for (int i in cart.keys) {
      if (cart[i]!.items[itemId] == null) continue;
      for (var item in cart[i]!.items[itemId]!.entries) {
        item.value.discount = null;
      }
    }
    update();
  }

  void fixCart() {
    List<int> keys = cart.keys.toList();
    for (int i in keys) {
      bool? empty = cart[i]?.fixOrder();
      if (empty ?? false) {
        cart.remove(i);
      }
    }
    update();
  }

  void clearCart() {
    cart.clear();
  }

  List<MapEntry<int, ItemModel>> expandItem(int orderId) {
    return cart[orderId]!.items.entries
        .expand((outerEntry) => outerEntry.value.entries)
        .toList();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    cart = AppServices.cart ?? {};
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   print('---------------------');
  //   if (state == AppLifecycleState.paused ||
  //       state == AppLifecycleState.detached) {
  //     print("App is going to background or closed — saving order...");
  //     print('--------------------------------');
  //     await AppServices2.saveCart(cart);
  //   }
  // }
}
