import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/utils/check_location_permission.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class DefaultLocationBox extends StatelessWidget {
  const DefaultLocationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.sidePaddingX2),
      child: Column(
        spacing: SizeConfig.sidePadding,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: SizeConfig.sidePadding,
            children: [
              Icon(Icons.person_pin_circle_sharp, color: elegantYellow),
              Text(AppServices.defaultLocation!['locationName']),
            ],
          ),
          SizedBox(height: SizeConfig.sidePadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                title: 'change',
                isSelected: true,
                onTap: () {
                  Get.back();
                  Get.toNamed('/locationPage');
                },
              ),
              //
              CustomButton(
                title: 'see on map',
                isSelected: true,
                onTap: () {
                  LocationPermissionChecker.quickCheck().then((enabled) {
                    if (enabled) {
                      Get.back();
                      Get.toNamed(
                        '/locationPage',
                        arguments: {
                          'location': LatLng(
                            AppServices.defaultLocation!['Lat'],
                            AppServices.defaultLocation!['Lng'],
                          ),
                        },
                      );
                    } else {
                      createSnackBar(
                        message: 'please enable location services.',
                      );
                    }
                  });
                },
              ),
              //
            ],
          ),
        ],
      ),
    );
  }
}
