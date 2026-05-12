import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/controller/benefits_controller.dart';
import 'package:fork_mate/models/customer/coupon_model.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/coupon_box.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/shared_widget/waiting_indicator.dart';

class CouponsPage extends StatelessWidget {
  CouponsPage({super.key});
  final BenefitsController controller = Get.put(BenefitsController());
  @override
  Widget build(BuildContext context) {
    controller.fetchDiscountCoupon();
    return Scaffold(
      appBar: BackAppBar(title: 'My Coupons'),
      body: Column(
        children: [
          GetX<BenefitsController>(
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                child: SizedBox(
                  height: SizeConfig.height * 0.03,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CustomButton(
                        title: "discount",
                        isSelected:
                            controller.type.value ==
                            ItemType.discountCoupon.name,
                        onTap: () {
                          controller.setCouponType(
                            ItemType.discountCoupon.name,
                          );
                        },
                      ),
                      SizedBox(width: SizeConfig.sidePadding),
                      CustomButton(
                        title: "free delivery",
                        isSelected:
                            controller.type.value ==
                            ItemType.freeDeliveryCoupon.name,
                        onTap: () {
                          controller.setCouponType(
                            ItemType.freeDeliveryCoupon.name,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            flex: 1,
            child: GetX<BenefitsController>(
              builder: (controller) {
                final List<CouponModel>? coupons =
                    controller.type.value == ItemType.discountCoupon.name
                    ? controller.discountCoupons.value
                    : controller.freeDeliveryCoupons.value;
                if (controller.couponChecker("ERROR")) {
                  return NetworkError(
                    onTap: () {
                      if (controller.type.value ==
                          ItemType.discountCoupon.name) {
                        controller.fetchDiscountCoupon();
                      } else {
                        controller.fetchFreeDeliveryCoupons();
                      }
                    },
                  );
                }
                if (controller.couponChecker("FETCHING")) {
                  return WaitingIndicator();
                }
                if (controller.couponChecker("EMPTY")) {
                  return CenterMessage(message: 'you dont have any coupon');
                }
                return RefreshIndicator(
                  onRefresh: controller.reFresh,
                  color: elegantYellow,
                  child: CustomScrollView(
                    slivers: [
                      if (controller.type.value == ItemType.discountCoupon.name)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(SizeConfig.sidePadding),
                            child: Text(
                              'Use the coupon code and your username when ordering directly from the restaurant to receive the discount.'
                                  .tr,
                              style: TextStyle(fontSize: SizeConfig.fontXSmall),
                            ),
                          ),
                        ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: coupons!.length,
                          (context, index) {
                            return CouponBox(couponModel: coupons[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
