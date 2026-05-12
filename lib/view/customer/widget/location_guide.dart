import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get_utils/get_utils.dart';

class LocationGuide extends StatelessWidget {
  const LocationGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.sidePaddingX2,
          horizontal: SizeConfig.sidePadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'press this icon'.tr),
                  TextSpan(text: '  '),
                  WidgetSpan(
                    child: Icon(
                      Icons.my_location_outlined,
                      color: elegantYellow,
                    ),
                  ),
                  TextSpan(text: '  '),
                  TextSpan(text: 'to locate you current location'.tr),
                ],
              ),
            ),
            Text(
              'or'.tr,
              style: TextStyle(
                color: elegantYellow,
                fontSize: SizeConfig.fontLarge,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'select location on the map, then press this icon'.tr,
                  ),
                  TextSpan(text: '  '),
                  WidgetSpan(
                    child: Icon(
                      Icons.straighten_outlined,
                      color: elegantYellow,
                    ),
                  ),
                  TextSpan(text: '  '),
                  TextSpan(
                    text:
                        'to see selected location details (distance, coast, ...)'
                            .tr,
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.sidePadding),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'finally, press this icon'.tr),
                  TextSpan(text: '  '),
                  WidgetSpan(child: Icon(Icons.check, color: elegantYellow)),
                  TextSpan(text: '  '),
                  TextSpan(
                    text: 'to deliver your order in selected location'.tr,
                  ),
                ],
              ),
            ),
            Divider(),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'you can set the location as default location'.tr,
                  ),
                  TextSpan(text: ' '),
                  TextSpan(text: 'by press'.tr),

                  TextSpan(text: '  '),

                  TextSpan(
                    text: 'set as default location'.tr,
                    style: TextStyle(color: elegantYellow),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
