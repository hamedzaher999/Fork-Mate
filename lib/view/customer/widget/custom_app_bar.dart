import 'package:flutter/material.dart';
import 'package:fork_mate/controller/customer_home_page_controller.dart';
import 'package:fork_mate/controller/notifications_controller.dart';
import 'package:fork_mate/functions/display_customer_point.dart';
import 'package:fork_mate/view/shared_widget/icon_with_dot_indicator.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.widget, this.displayIcons = true});
  final Widget? widget;
  final bool displayIcons;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Icon(Icons.av_timer_sharp, color: elegantYellow),
              SizedBox(width: SizeConfig.width * 0.02),
              GetX<CustomerHomePageController>(
                builder: (controller) {
                  return Text(
                    controller.storeStatus.value == null
                        ? '.....'
                        : controller.storeStatus.value!
                        ? "open".tr
                        : "close".tr,
                    style: TextStyle(
                      color: controller.storeStatus.value == true
                          ? Colors.green
                          : Colors.red,
                      fontSize: SizeConfig.fontMedium,
                    ),
                  );
                },
              ),
            ],
          ),
          widget ?? SizedBox(),
          if (displayIcons)
            Row(
              children: [
                GetX<NotificationsController>(
                  builder: (controller) {
                    return IconWithDotIndicator(
                      icon: Icons.paid_outlined,
                      notification: controller.hasNewCoupons.value,
                      onTap: () {
                        displayCustomerPoints();
                      },
                    );
                  },
                ),
                SizedBox(width: SizeConfig.sidePadding),
                GetX<NotificationsController>(
                  builder: (controller) {
                    return IconWithDotIndicator(
                      icon: Icons.wallet_giftcard_rounded,
                      notification: controller.hasNewGifts.value,
                      onTap: () {
                        Get.toNamed('/giftsPage');
                      },
                    );
                  },
                ),
                SizedBox(width: SizeConfig.sidePadding),
                GetX<NotificationsController>(
                  builder: (controller) {
                    return IconWithDotIndicator(
                      icon: Icons.discount,
                      notification: controller.hasNewCoupons.value,
                      onTap: () {
                        Get.toNamed('/couponPage');
                      },
                    );
                  },
                ),
                SizedBox(width: SizeConfig.sidePadding),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/locationPage');
                  },
                  child: Icon(Icons.location_on, color: elegantYellow),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
