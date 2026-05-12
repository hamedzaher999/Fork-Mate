import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:fork_mate/utils/check_location_permission.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/one_line_note.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:latlong2/latlong.dart';

class DeliveryDetailsBox extends StatelessWidget {
  const DeliveryDetailsBox({super.key, required this.order});
  final RunningOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.sidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('delivery method'.tr),
                    Text(order.deliveryDetails.method.tr),
                  ],
                ),
                if (order.deliveryDetails.method == 'delivery' &&
                    order.deliveryDetails.details != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.sidePadding / 2),
                      OneLineNote(
                        note: [
                          "location".tr,
                          ":",
                          order.deliveryDetails.details!.name,
                        ],
                        color: elegantYellow,
                      ),
                      OneLineNote(
                        note: [
                          "distance".tr,
                          ":",
                          order.deliveryDetails.details!.distance.toString(),
                          "meter".tr,
                        ],
                        color: Colors.blue,
                      ),
                      OneLineNote(
                        note: [
                          "delivery coast".tr,
                          ":",
                          order.isGift
                              ? 'free delivery'.tr
                              : formatPrice(
                                  order.deliveryDetails.details!.price,
                                ),
                        ],
                        color: Colors.green,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: CustomButton(
                          title: 'see on map'.tr,
                          isSelected: true,
                          onTap: () async {
                            if (!await LocationPermissionChecker.quickCheck()) {
                              LocationPermissionChecker.start();
                              return;
                            }
                            final lat = order.deliveryDetails.details!.latitude;
                            final lng =
                                order.deliveryDetails.details!.longitude;
                            Get.toNamed(
                              '/locationPage',
                              arguments: {'location': LatLng(lat, lng)},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
