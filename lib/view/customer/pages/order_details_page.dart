import 'package:flutter/material.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/bottom_sheet.dart';
import 'package:fork_mate/view/customer/widget/floating_field.dart';
import 'package:fork_mate/view/sections/methods_section.dart';
import 'package:fork_mate/view/sections/notes_section.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends GetView<OrderDetailsController> {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title: "N-${controller.orderId + 1}"),
      body: SizedBox(
        height: SizeConfig.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.sidePaddingX2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetX<OrderDetailsController>(
                          builder: (controller) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("item coast".tr),
                                    Text(
                                      formatPrice(controller.orderPrice),
                                      style: TextStyle(
                                        color: Colors.green,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.sidePadding / 2),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("delivery coast".tr),
                                    Text(
                                      controller.usedFreeDeliveryCoupon.value !=
                                              null
                                          ? 'free delivery'.tr
                                          : controller.locationDetails.value ==
                                                null
                                          ? '.......'
                                          : formatPrice(
                                              controller
                                                  .locationDetails
                                                  .value!
                                                  .price,
                                            ),
                                      style: TextStyle(
                                        color: Colors.green,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),

                    //---------------
                    MethodsSection(),
                    //----
                    SizedBox(height: SizeConfig.sidePaddingX2),
                    Row(
                      spacing: SizeConfig.sidePadding / 2,
                      children: [
                        CustomButton(
                          hasShadow: false,
                          title: 'coupon'.tr,
                          isSelected: true,
                          fontSize: SizeConfig.fontXXSmall,
                          onTap: () {
                            controller.getCoupons();
                          },
                        ),
                        CustomButton(
                          hasShadow: false,
                          title: 'free delivery coupon'.tr,
                          isSelected: true,
                          fontSize: SizeConfig.fontXXSmall,
                          onTap: () {
                            controller.getFreeDeliveryCoupon();
                          },
                        ),
                        CustomButton(
                          hasShadow: false,
                          title: 'discount code'.tr,
                          isSelected: true,
                          fontSize: SizeConfig.fontXXSmall,
                          onTap: () {
                            Get.dialog(
                              FloatingField(
                                onSubmit: controller.useDiscountCode,
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    //--------------
                    NotesSection(orderModel: controller.orderModel),
                    //-----------
                    SizedBox(height: SizeConfig.height * 0.15),
                  ],
                ),
              ),
            ),
            CustomBottomSheet(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.sidePadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'final coast'.tr,
                          style: TextStyle(fontSize: SizeConfig.fontMedium),
                        ),
                        GetX<OrderDetailsController>(
                          builder: (controller) {
                            return Text(
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: SizeConfig.fontMedium,
                              ),
                              formatPrice(controller.finalPrice.value),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.width * 0.7,
                      child: Text(
                        'The final price after applying all the types of discounts you have used.'
                            .tr,
                        style: TextStyle(fontSize: SizeConfig.fontXXSmall),
                      ),
                    ),
                    SizedBox(height: SizeConfig.sidePadding),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: CustomButton(
                        hasShadow: false,
                        title: 'order',
                        isSelected: true,
                        fontSize: SizeConfig.fontXSmall,
                        onTap: () async {
                          controller.order();
                        },
                      ),
                    ),

                    SizedBox(height: SizeConfig.sidePadding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
