import 'package:flutter/material.dart';
import 'package:fork_mate/controller/benefits_controller.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/models/customer/customer_gift_model.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/format_date.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/sticker.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';

class GiftBox extends GetView<BenefitsController> {
  const GiftBox({super.key, required this.giftModel});
  final CustomerGiftModel giftModel;
  @override
  Widget build(BuildContext context) {
    controller.setAsSeen(type: 'gift', id: giftModel.id, seen: giftModel.seen);
    return Padding(
      padding: EdgeInsets.all(SizeConfig.sidePadding),
      child: Container(
        decoration: boxDecoration,
        width: SizeConfig.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.radius),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: SizeConfig.height * 0.17,
                ),
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: SizeConfig.sidePaddingX2 * 2,
                      ),
                      child: Text.rich(
                        TextSpan(
                          // text: 'مبروك !!  هدية الك',
                          text: 'Congratulation!! a gift for you'.tr,
                          style: TextStyle(fontSize: SizeConfig.fontSmall),
                          children: [
                            TextSpan(text: '  '),
                            TextSpan(
                              text: giftModel.description,
                              style: TextStyle(fontSize: SizeConfig.fontSmall),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.sidePadding),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order your gift now, and we’ll cover the delivery cost!"
                              .tr,
                          style: TextStyle(fontSize: SizeConfig.fontXSmall),
                        ),
                        SizedBox(height: SizeConfig.sidePadding / 2),

                        CustomButton(
                          title: 'order now',
                          isSelected: true,
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.sidePadding,
                                    horizontal: SizeConfig.sidePaddingX2,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'would you like to order only the gift, or add it to your current order?'
                                            .tr,
                                      ),
                                      SizedBox(
                                        height: SizeConfig.sidePaddingX2 * 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomButton(
                                            title: 'only the gift',
                                            isSelected: true,
                                          ),
                                          CustomButton(
                                            title: 'add to the order',
                                            isSelected: true,
                                            onTap: () {
                                              Get.back();

                                              Get.find<CartController>()
                                                  .addGiftToTheCurrentOrder(
                                                    giftModel,
                                                  );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.sidePadding),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'gift number'.tr,
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontXSmall,
                                  ),
                                ),
                                Text(' : '),
                                Text(
                                  giftModel.giftNumber,
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontXSmall,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              formatDate(giftModel.createdAt.toString()),
                              style: TextStyle(fontSize: SizeConfig.fontXSmall),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Sticker(shimmer: true),
            ],
          ),
        ),
      ),
    );
  }
}
