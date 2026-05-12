import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/models/customer/coupon_model.dart';
import 'package:fork_mate/models/customer/customer_gift_model.dart';
import 'package:fork_mate/services/customer/customer_data_services.dart';
import 'package:get/get.dart';

class BenefitsController extends GetxController {
  RxString type = ItemType.discountCoupon.name.obs;
  //fetching  flags
  RxBool isCouponsFetching = false.obs;
  RxBool isFreeDeliveryCouponsFetching = false.obs;
  RxBool isGiftsFetching = false.obs;
  //network error flags
  RxBool couponsFetchingError = false.obs;
  RxBool freeDeliveryCouponsError = false.obs;
  RxBool giftsFetchingError = false.obs;
  Rx<List<CouponModel>?> discountCoupons = Rx(null);
  Rx<List<CouponModel>?> freeDeliveryCoupons = Rx(null);
  Rx<List<CustomerGiftModel>?> gifts = Rx(null);

  void setCouponType(String type) {
    this.type.value = type;
    if (this.type.value == ItemType.discountCoupon.name &&
        discountCoupons.value == null) {
      fetchDiscountCoupon();
    } else if (this.type.value == ItemType.freeDeliveryCoupon.name &&
        freeDeliveryCoupons.value == null) {
      fetchFreeDeliveryCoupons();
    }
  }

  bool couponChecker(String checkerType) {
    if (checkerType == 'EMPTY') {
      if (type.value == ItemType.discountCoupon.name) {
        return discountCoupons.value?.isEmpty ?? false;
      } else {
        return freeDeliveryCoupons.value?.isEmpty ?? false;
      }
    } else if (checkerType == 'ERROR') {
      if (type.value == ItemType.discountCoupon.name) {
        return couponsFetchingError.value;
      } else {
        return freeDeliveryCouponsError.value;
      }
    } else if (checkerType == 'FETCHING') {
      if (type.value == ItemType.discountCoupon.name) {
        return discountCoupons.value == null;
      } else {
        return freeDeliveryCoupons.value == null;
      }
    }
    return false;
  }

  Future<void> reFresh() async {
    await Future.delayed(Duration(seconds: 1));
    if (type.value == ItemType.discountCoupon.name) {
      discountCoupons.value = null;
      fetchDiscountCoupon();
    } else {
      freeDeliveryCoupons.value = null;
      fetchFreeDeliveryCoupons();
    }
  }

  Future<void> fetchDiscountCoupon() async {
    couponsFetchingError.value = false;
    if (!isCouponsFetching.value) {
      isCouponsFetching.value = true;
      try {
        List<CouponModel> activator = await CustomerDataServices.fetchCoupons();
        if (isClosed) return;
        for (var element in activator) {
          if (isClosed) return;
          final timer = CountdownController(
            timeString: element.remainingTime,
            tag: element.tag,
          );
          timer.callBackMap[element.tag] = () {
            discountCoupons.value!.remove(element);
            discountCoupons.refresh();
          };

          Get.put(timer, tag: timer.tag);
        }
        discountCoupons.value = activator;
      } catch (e) {
        couponsFetchingError.value = true;
      } finally {
        isCouponsFetching.value = false;
      }
    }
  }

  Future<void> disposer() async {
    if (discountCoupons.value != null) {
      for (var element in discountCoupons.value!) {
        if (Get.isRegistered<CountdownController>(tag: element.tag)) {
          Get.delete<CountdownController>(tag: element.tag);
        }
      }
    }
    if (freeDeliveryCoupons.value != null) {
      for (var element in freeDeliveryCoupons.value!) {
        if (Get.isRegistered<CountdownController>(tag: element.tag)) {
          Get.delete<CountdownController>(tag: element.tag);
        }
      }
    }
  }

  Future<void> fetchFreeDeliveryCoupons() async {
    freeDeliveryCouponsError.value = false;
    if (!isFreeDeliveryCouponsFetching.value) {
      isFreeDeliveryCouponsFetching.value = true;
      try {
        List<CouponModel> activator =
            await CustomerDataServices.fetchFreeDeliveryCoupons();
        if (isClosed) return;
        for (var element in activator) {
          if (isClosed) return;
          final timer = CountdownController(
            tag: element.tag,
            timeString: element.remainingTime,
          );
          timer.callBackMap[element.tag] = () {
            freeDeliveryCoupons.value!.remove(element);
            freeDeliveryCoupons.refresh();
          };
          Get.put(timer, tag: timer.tag);
        }
        freeDeliveryCoupons.value = activator;
      } catch (e) {
        freeDeliveryCouponsError.value = true;
      } finally {
        isFreeDeliveryCouponsFetching.value = false;
      }
    }
  }

  Future<void> fetchGifts() async {
    giftsFetchingError.value = false;
    if (!isGiftsFetching.value) {
      isGiftsFetching.value = true;
      try {
        gifts.value = await CustomerDataServices.fetchGifts();
      } catch (e) {
        giftsFetchingError.value = true;
      } finally {
        isGiftsFetching.value = false;
      }
    }
  }

  Future<void> setAsSeen({
    required String type,
    required int id,
    required bool seen,
  }) async {
    if (seen) return;
    bool success = await CustomerDataServices.setAsSeen(type: type, id: id);
    print(success);
  }
}
