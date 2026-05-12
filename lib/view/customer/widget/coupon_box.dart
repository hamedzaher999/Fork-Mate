import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/benefits_controller.dart';
import 'package:fork_mate/functions/format_date.dart';
import 'package:fork_mate/models/customer/coupon_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/countdown_timer.dart';
import 'package:fork_mate/view/customer/widget/sticker.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CouponBox extends GetView<BenefitsController> {
  const CouponBox({super.key, required this.couponModel});
  final CouponModel couponModel;
  @override
  Widget build(BuildContext context) {
    controller.setAsSeen(
      type: couponModel.type,
      id: couponModel.id,
      seen: couponModel.seen,
    );
    return Padding(
      padding: EdgeInsets.all(SizeConfig.sidePadding),
      child: Container(
        decoration: boxDecoration,
        height: SizeConfig.height * 0.18,
        width: SizeConfig.width,
        child: Stack(
          children: [
            Center(
              child: Shimmer.fromColors(
                baseColor: mainColor,
                highlightColor: elegantYellow,
                child: couponModel.type == 'discount_coupon'
                    ? Text(
                        '${couponModel.discount}%',
                        style: TextStyle(
                          color: Colors.transparent,
                          fontSize: SizeConfig.fontXLarge * 3,
                          height: 2,
                          shadows: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 0.3,
                              color: const Color.fromARGB(143, 255, 217, 0),
                            ),
                          ],
                        ),
                      )
                    : Icon(
                        Icons.directions_bike_rounded,
                        size: SizeConfig.fontXLarge * 2,
                      ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(SizeConfig.sidePadding),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    couponModel.type == 'discount_coupon'
                        ? 'You’ve received a   @value % off coupon!'.trParams({
                            'value': couponModel.discount.toStringAsFixed(1),
                          })
                        : "You’ve received a free delivery coupon!".tr,
                    style: TextStyle(fontSize: SizeConfig.fontSmall),
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'coupon number'.tr,
                            style: TextStyle(fontSize: SizeConfig.fontXSmall),
                          ),
                          Text('  :  '),
                          Text(
                            couponModel.couponNumber,
                            style: TextStyle(fontSize: SizeConfig.fontXSmall),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'coupon Validity'.tr,
                                style: TextStyle(
                                  fontSize: SizeConfig.fontXSmall,
                                ),
                              ),
                              Text('  :  '),
                              CountdownTimer(
                                icon: false,
                                tag: couponModel.tag,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          Text(
                            formatDate(couponModel.createdAt.toString()),
                            style: TextStyle(fontSize: SizeConfig.fontXSmall),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //-----
            Sticker(color: const Color.fromARGB(146, 249, 217, 37)),
          ],
        ),
      ),
    );
  }
}
