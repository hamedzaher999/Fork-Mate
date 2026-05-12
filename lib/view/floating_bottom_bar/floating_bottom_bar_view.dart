import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/floating_bottom_bar/bottom_navigation_icon.dart';
import 'package:fork_mate/view/floating_bottom_bar/floating_bottom_bar_controller.dart';

class FloatingBottomBar extends GetView<FloatingBottomBarController> {
  const FloatingBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.sidePadding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.width * 0.05),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: SizeConfig.width,
            height: SizeConfig.width * 0.15,
            decoration: BoxDecoration(
              color: elegantYellow.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
            ),
            child: GetBuilder<FloatingBottomBarController>(
              builder: (controller) => Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: Pages.values.map((page) {
                    return BottomNavigationIcon(page: page);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
