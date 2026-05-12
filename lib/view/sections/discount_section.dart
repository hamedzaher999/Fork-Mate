import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/view/customer/widget/discount_box.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:fork_mate/view/shimmers/discount_box_shimmer.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/customer_home_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection({super.key});
  @override
  Widget build(BuildContext context) {
    return GetX<CustomerHomePageController>(
      builder: (controller) {
        if (controller.discountNetworkError.value) {
          return SizedBox(
            height: SizeConfig.width * 0.45,
            child: NetworkError(
              onTap: () {
                controller.refreshDiscounts();
              },
            ),
          );
        }
        return SizedBox(
          width: SizeConfig.width,
          height: SizeConfig.width * 0.45,

          child: controller.discounts.value == null
              ? ListView.separated(
                  padding: EdgeInsetsDirectional.all(SizeConfig.sidePadding),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (_, index) {
                    return DiscountBoxShimmer();
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: SizeConfig.sidePadding),
                )
              : controller.discounts.value!.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsetsDirectional.all(SizeConfig.sidePadding),
                  scrollDirection: Axis.horizontal,
                  controller: controller.discountListController,
                  itemCount: controller.discounts.value!.length + 1,
                  itemBuilder: (_, index) =>
                      index < controller.discounts.value!.length
                      ? DiscountBox(
                          itemModel: controller.discounts.value![index],
                        )
                      : Center(
                          child: Obx(
                            () => controller.isDiscountFetching.value
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: SizeConfig.sidePadding,
                                    ),
                                    child: MiniCircularIndicator(
                                      color: elegantYellow,
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ),
                  separatorBuilder: (context, index) =>
                      SizedBox(width: SizeConfig.sidePadding / 2),
                )
              : CenterMessage(icon: Icons.report),
        );
      },
    );
  }
}
