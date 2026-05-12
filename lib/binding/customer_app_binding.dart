import 'package:fork_mate/controller/ads_section_controller.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/controller/customer_home_page_controller.dart';
import 'package:fork_mate/controller/notifications_controller.dart';
import 'package:fork_mate/controller/search_request_controller.dart';
import 'package:fork_mate/controller/setting_controller.dart';
import 'package:fork_mate/view/floating_bottom_bar/floating_bottom_bar_controller.dart';
import 'package:get/instance_manager.dart';

class CustomerAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AdsControllerController());
    Get.put(FloatingBottomBarController(), permanent: true);
    Get.put(CustomerHomePageController(), permanent: true);
    Get.put(NotificationsController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<SearchRequestController>(
      () => SearchRequestController(),
      fenix: true,
    );
  }
}
