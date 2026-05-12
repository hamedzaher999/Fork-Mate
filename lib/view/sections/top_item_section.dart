import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/customer_home_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/customer/widget/top_item_box.dart';
import 'package:fork_mate/view/shimmers/top_item_shimmer.dart';

class TopItemSection extends StatelessWidget {
  const TopItemSection({super.key});
  @override
  Widget build(BuildContext context) {
    return GetX<CustomerHomePageController>(
      builder: (controller) {
        if (controller.topItemsNetworkError.value) {
          return SizedBox(
            height: SizeConfig.width * 0.3,
            child: NetworkError(
              onTap: () {
                controller.refreshTopItem();
              },
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: SizeConfig.sidePadding * 0.5),
          child: SizedBox(
            width: SizeConfig.width,
            height: SizeConfig.width * 0.3,
            child: controller.topItems.value == null
                ? ListView.separated(
                    padding: EdgeInsetsDirectional.all(SizeConfig.sidePadding),
                    scrollDirection: Axis.horizontal,
                    controller: controller.topItemsListController,
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return TopItemShimmer();
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(width: SizeConfig.sidePadding),
                  )
                : controller.topItems.value!.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsetsDirectional.all(SizeConfig.sidePadding),

                    controller: controller.topItemsListController,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.topItems.value!.length + 1,
                    itemBuilder: (_, index) =>
                        index < controller.topItems.value!.length
                        ? TopItemBox(
                            itemModel: controller.topItems.value![index],
                          )
                        : Center(
                            child: Obx(
                              () => controller.isTopItemFetching.value
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
                        SizedBox(width: SizeConfig.sidePadding),
                  )
                : CenterMessage(icon: Icons.report),
          ),
        );
      },
    );
  }
}
