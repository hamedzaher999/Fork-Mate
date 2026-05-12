import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/location_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/location_details_box.dart';
import 'package:fork_mate/view/customer/widget/location_guide.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LocationDetailsCard extends GetView<LocationController> {
  const LocationDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (controller.locationDetails.value != null)
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: SizeConfig.sidePadding,
              end: SizeConfig.sidePadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back(result: controller.locationDetails.value);
                  },
                  child: Container(
                    width: SizeConfig.width * 0.12,
                    height: SizeConfig.width * 0.12,
                    decoration: BoxDecoration(
                      boxShadow: shadow,
                      borderRadius: BorderRadius.circular(50),
                      color: backGroundColor,
                    ),
                    child: Icon(MdiIcons.check, color: elegantYellow),
                  ),
                ),
                CustomButton(
                  title: 'set as default',
                  isSelected: true,
                  fontSize: SizeConfig.fontXSmall,
                  onTap: () {
                    controller.setDefaultLocation();
                  },
                ),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.all(SizeConfig.sidePadding),
          child: Container(
            padding: EdgeInsets.all(SizeConfig.sidePadding),
            width: SizeConfig.width,
            height: SizeConfig.height * 0.16,
            decoration: BoxDecoration(
              color: backGroundColor,
              boxShadow: shadow,
              borderRadius: BorderRadius.circular(SizeConfig.radius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<LocationController>(
                  builder: (controller) {
                    return controller.locationDetails.value != null
                        ? LocationDetailsBox(
                            locationsModel: controller.locationDetails.value!,
                          )
                        : CustomButton(
                            onTap: () {
                              Get.dialog(LocationGuide());
                            },
                            icon: Icons.info_outline,
                            isSelected: true,
                          );
                  },
                ),
                //icons
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (controller.myLocation.value != null)
                      GestureDetector(
                        onTap: () {
                          controller.measure();
                        },
                        child: Container(
                          width: SizeConfig.width * 0.1,
                          height: SizeConfig.width * 0.1,
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            borderRadius: BorderRadius.circular(50),
                            color: backGroundColor,
                          ),
                          child: Icon(MdiIcons.ruler, color: elegantYellow),
                        ),
                      ),
                    SizedBox(height: SizeConfig.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        controller.getMyLocation();
                      },
                      child: Container(
                        width: SizeConfig.width * 0.14,
                        height: SizeConfig.width * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: shadow,
                          color: elegantYellow,
                        ),
                        child: Icon(
                          Icons.my_location_rounded,
                          color: mainColor,
                          size: SizeConfig.fontXLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
