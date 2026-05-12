import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/order_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/coupons_grid.dart';
import 'package:fork_mate/view/customer/widget/location_details_box.dart';
import 'package:fork_mate/view/customer/widget/one_line_note.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotesSection extends GetView<OrderDetailsController> {
  const NotesSection({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetX<OrderDetailsController>(
          builder: (controller) {
            return Column(
              children: [
                GetX<OrderDetailsController>(
                  builder: (controller) {
                    return Column(
                      children:
                          controller.deliveryMethod.value == restaurantPickup
                          ? [
                              SizedBox(height: SizeConfig.sidePadding),
                              Divider(),
                            ]
                          : [
                              SizedBox(height: SizeConfig.sidePadding),
                              if (controller.locationDetails.value != null)
                                OneLineNote(
                                  note: orderModel.isGiftsOnly()
                                      ? ['free delivery']
                                      : [
                                          'delivery coast for selected location',
                                          ' ',
                                          formatPrice(
                                            controller
                                                .locationDetails
                                                .value!
                                                .price,
                                          ),
                                          '',
                                        ],
                                  color: Colors.blue,
                                  suffix: GestureDetector(
                                    onTap: () {
                                      Get.dialog(
                                        Dialog(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  SizeConfig.sidePaddingX2,
                                              vertical: SizeConfig.sidePadding,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                LocationDetailsBox(
                                                  locationsModel: controller
                                                      .locationDetails
                                                      .value!,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      MdiIcons.information,
                                      size: SizeConfig.fontRegular,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              Divider(),
                            ],
                    );
                  },
                ),
                ...controller.usedCoupons.value.entries.map((coupon) {
                  return OneLineNote(
                    note: [
                      'A coupon worth',
                      ' ',
                      coupon.value.toString(),
                      '%',
                      ' ',
                      'has been activated',
                    ],
                    color: Colors.green,
                  );
                }),
                ...controller.usedCode.value.entries.map((discount) {
                  return OneLineNote(
                    note: [
                      'A discount code of',
                      ' ',
                      discount.value.toString(),
                      '%',
                      ' ',
                      'has been applied',
                    ],
                    color: elegantYellow,
                  );
                }),
                if (controller.usedFreeDeliveryCoupon.value != null)
                  OneLineNote(
                    note: ['A free delivery coupon has been used'],
                    color: Colors.blue,
                  ),
              ],
            );
          },
        ),

        SizedBox(height: SizeConfig.sidePadding),

        GetX<OrderDetailsController>(
          builder: (controller) {
            if (controller.discountCoupons.value != null ||
                controller.freeDeliveryCoupon.value != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'select the coupons you want to apply to this order'.tr,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: SizeConfig.fontXXSmall,
                    ),
                  ),
                  if (controller.discountCoupons.value != null) ...[
                    SizedBox(height: SizeConfig.sidePadding / 2),
                    Text(
                      'discount coupons'.tr,
                      style: TextStyle(fontSize: SizeConfig.fontXSmall),
                    ),
                    SizedBox(height: SizeConfig.sidePadding),

                    CouponsGrid(coupons: controller.discountCoupons.value!),
                  ],
                  //discount coupons
                  if (controller.freeDeliveryCoupon.value != null) ...[
                    //free delivery coupons
                    SizedBox(height: SizeConfig.sidePadding),
                    Text(
                      'free delivery coupons'.tr,
                      style: TextStyle(fontSize: SizeConfig.fontXSmall),
                    ),
                    SizedBox(height: SizeConfig.sidePadding),

                    if (controller.freeDeliveryCoupon.value != null)
                      CouponsGrid(
                        coupons: controller.freeDeliveryCoupon.value!,
                      ),
                  ],
                  SizedBox(height: SizeConfig.sidePaddingX2),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
