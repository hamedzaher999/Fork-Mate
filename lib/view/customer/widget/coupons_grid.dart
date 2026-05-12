import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/models/customer/coupon_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/countdown_timer.dart';
import 'package:get/get.dart';

class CouponsGrid extends GetView<OrderDetailsController> {
  const CouponsGrid({super.key, required this.coupons});
  final List<CouponModel> coupons;
  @override
  Widget build(BuildContext context) {
    return GetX<OrderDetailsController>(
      builder: (controller) {
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: SizeConfig.sidePadding,
          crossAxisSpacing: SizeConfig.sidePadding,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 5,
          children: coupons.map((coupon) {
            return GestureDetector(
              onTap: () {
                controller.useCoupon(coupon);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.sidePadding,
                ),
                decoration: BoxDecoration(
                  color: controller.isCouponUsed(coupon)
                      ? Colors.green.withAlpha(90)
                      : mainColor,

                  borderRadius: BorderRadius.circular(SizeConfig.radius / 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: TextStyle(fontSize: SizeConfig.fontXXSmall),
                      '${coupon.discount.toStringAsFixed(1)} %',
                    ),
                    CountdownTimer(
                      fontSize: SizeConfig.fontXXSmall,
                      tag: coupon.tag,
                      icon: false,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
