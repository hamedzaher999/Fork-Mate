import 'package:flutter/material.dart';
import 'package:fork_mate/controller/notifications_controller.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/floating_bottom_bar/floating_bottom_bar_controller.dart';

class BottomNavigationIcon extends GetView<FloatingBottomBarController> {
  const BottomNavigationIcon({
    super.key,
    required this.page,
    this.notification = false,
  });
  final Pages page;
  final bool notification;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.sidePadding),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => controller.setPage(page),
          child: GetX<NotificationsController>(
            builder: (notificationsController) {
              return Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              page.icon,
                              color: controller.page == page
                                  ? null
                                  : Colors.grey,
                            ),
                            if (notificationsController
                                    .hasRunningOrders
                                    .value &&
                                page == Pages.cart)
                              PositionedDirectional(
                                top: -2,
                                start: -2,
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: SizeConfig.fontXSmall / 2,
                                ),
                              ),
                          ],
                        ),
                        if (controller.page == page)
                          Icon(Icons.circle, size: SizeConfig.width * 0.015),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
