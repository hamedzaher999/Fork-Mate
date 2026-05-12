import 'package:flutter/material.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/location_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/read_dialog.dart';
import 'package:get/get.dart';

class LocationDetailsBox extends StatelessWidget {
  const LocationDetailsBox({super.key, required this.locationsModel});
  final LocationsModel locationsModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: SizeConfig.width * 0.7,
          child: GestureDetector(
            onTap: () {
              Get.dialog(
                ReadDialog(
                  text: locationsModel.targetName ?? 'unknown location'.tr,
                ),
              );
            },
            child: Text(
              locationsModel.targetName ?? 'unknown location'.tr,
              style: TextStyle(
                fontSize: SizeConfig.fontSmall,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.sidePadding),
        Padding(
          padding: EdgeInsetsDirectional.only(start: SizeConfig.sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: SizeConfig.fontSmall),
                  children: [
                    TextSpan(text: 'distance'.tr),
                    TextSpan(text: '  '),
                    TextSpan(
                      text: locationsModel.distance.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(text: '  '),
                    TextSpan(text: 'meter'.tr),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: SizeConfig.fontSmall),
                  children: [
                    TextSpan(text: 'coast'.tr),
                    TextSpan(text: '  '),
                    TextSpan(
                      text: formatPrice(locationsModel.price),
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '  '),
                    TextSpan(text: '\$'),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: SizeConfig.fontSmall),
                  children: [
                    TextSpan(text: 'time'.tr),
                    TextSpan(text: '  '),
                    TextSpan(
                      text: (locationsModel.duration / 60).toStringAsFixed(0),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(text: '  '),
                    TextSpan(text: 'minute'.tr),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
