import 'package:fork_mate/services/customer/notifications_services.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  // hasNewGifts
  RxBool hasNewGifts = false.obs;
  RxBool hasNewCoupons = false.obs;
  RxBool hasRunningOrders = false.obs;
  RxBool hasCanceledOrders = false.obs;
  int newGiftsRequestCount = 0;
  int newCouponsRequestCount = 0;
  int runningOrderRequestCount = 0;
  int canceledOrderRequestCount = 0;

  @override
  void onInit() {
    newGifts();
    newCoupons();
    runningOrder();
    canceledOrder();
    super.onInit();
  }

  void newGifts() async {
    try {
      hasNewGifts.value = await NotificationsServices.hasNewGifts();
    } catch (_) {
      if (newGiftsRequestCount < 3) {
        print("gifts $newGiftsRequestCount");
        newGiftsRequestCount++;
        newGifts();
      } else {
        return;
      }
    }
  }

  void newCoupons() async {
    try {
      hasNewCoupons.value = await NotificationsServices.hasNewCoupons();
    } catch (_) {
      if (newCouponsRequestCount < 3) {
        print("newCoupons $newCouponsRequestCount");
        newCouponsRequestCount++;
        newCoupons();
      } else {
        return;
      }
    }
  }

  void runningOrder() async {
    try {
      hasRunningOrders.value = await NotificationsServices.hasRunningOrders();
    } catch (_) {
      if (runningOrderRequestCount < 3) {
        print("runningOrder $runningOrderRequestCount");
        runningOrderRequestCount++;
        runningOrder();
      } else {
        return;
      }
    }
  }

  void canceledOrder() async {
    try {
      hasCanceledOrders.value = await NotificationsServices.hasCanceledOrders();
    } catch (_) {
      if (canceledOrderRequestCount < 3) {
        print("canceledOrder $canceledOrderRequestCount");
        canceledOrderRequestCount++;
        canceledOrder();
      } else {
        return;
      }
    }
  }

  void seeGifts() {
    hasNewGifts.value = false;
  }

  void seeCoupons() {
    hasNewGifts.value = false;
  }
}
