import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/location_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get.dart';

class LocationPermissionSection extends GetView<LocationController> {
  const LocationPermissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            end: SizeConfig.sidePadding,
            top: SizeConfig.sidePadding * 4,
          ),

          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: elegantYellow,
              size: SizeConfig.width * 0.08,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off,
                  size: SizeConfig.width * 0.3,
                  color: elegantYellow,
                ),
                SizedBox(height: SizeConfig.height * 0.02),
                Text(
                  'this page needs location permission....'.tr,
                  style: TextStyle(fontSize: SizeConfig.width * 0.04),
                ),
                SizedBox(height: SizeConfig.height * 0.05),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
