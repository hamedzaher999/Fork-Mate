import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/models/customer/location_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/sticker.dart';
import 'package:get/get.dart';

class MethodsSection extends GetView<OrderDetailsController> {
  const MethodsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!controller.orderModel.isGiftsOnly()) ...[
          SizedBox(height: SizeConfig.sidePadding),
          Container(
            decoration: boxDecoration,

            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(SizeConfig.sidePadding),
                  child: Column(
                    children: [
                      Text(
                        'payment method'.tr,
                        style: TextStyle(fontSize: SizeConfig.fontSmall),
                      ),
                      SizedBox(height: SizeConfig.sidePadding),

                      GetX<OrderDetailsController>(
                        builder: (controller) {
                          return Column(
                            children: paymentMethods.entries.map((method) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  controller.paymentMethod.value == method.key
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.setPaymentMethod(null);
                                          },
                                          child: Icon(
                                            Icons.check_box_outlined,
                                            size: SizeConfig.fontRegular,
                                            color: elegantYellow,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            controller.setPaymentMethod(
                                              method.key,
                                            );
                                            method.value();
                                          },
                                          child: Icon(
                                            Icons
                                                .check_box_outline_blank_outlined,
                                            size: SizeConfig.fontRegular,
                                          ),
                                        ),
                                  SizedBox(width: SizeConfig.sidePadding),
                                  Text(
                                    method.key.tr,
                                    style: TextStyle(
                                      fontSize: SizeConfig.fontSmall,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                GetX<OrderDetailsController>(
                  builder: (controller) {
                    return controller.isPayed.value
                        ? Sticker(
                            shimmer: true,
                            text: 'paid',
                            color: const Color.fromARGB(163, 33, 149, 243),
                          )
                        : SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
        SizedBox(height: SizeConfig.sidePadding),
        Container(
          padding: EdgeInsets.all(SizeConfig.sidePadding),
          decoration: boxDecoration,
          child: Column(
            children: [
              Text(
                'delivery location',
                style: TextStyle(fontSize: SizeConfig.fontSmall),
              ),
              SizedBox(height: SizeConfig.sidePadding),

              GetX<OrderDetailsController>(
                builder: (controller) {
                  return Column(
                    children: deliveryMethods.entries.map((method) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controller.deliveryMethod.value == method.key
                              ? GestureDetector(
                                  onTap: () {
                                    controller.setDeliveryMethod(null, null);
                                  },
                                  child: Icon(
                                    Icons.check_box_outlined,
                                    size: SizeConfig.fontRegular,
                                    color: elegantYellow,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    LocationsModel? locationDetail =
                                        await method.value();
                                    controller.setDeliveryMethod(
                                      method.key,
                                      locationDetail,
                                    );
                                  },
                                  child: Icon(
                                    Icons.check_box_outline_blank_outlined,
                                    size: SizeConfig.fontRegular,
                                  ),
                                ),
                          SizedBox(width: SizeConfig.sidePadding),
                          Text(
                            method.key.tr,
                            style: TextStyle(fontSize: SizeConfig.fontSmall),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
