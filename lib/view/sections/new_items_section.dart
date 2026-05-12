import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:fork_mate/controller/customer_home_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/item_box.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/shimmers/item_box_shimmer.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class NewItemsSection extends StatelessWidget {
  const NewItemsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return GetX<CustomerHomePageController>(
      builder: (controller) {
        if (controller.newItemsNetworkError.value) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: SizeConfig.width * 0.35,
              child: NetworkError(
                onTap: () {
                  controller.refreshNewItem();
                },
              ),
            ),
          );
        }
        if (controller.newItems.value == null) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(childCount: 2, (
              context,
              index,
            ) {
              return ItemBoxShimmer();
            }),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: controller.newItems.value!.length + 1,
            (context, index) => index < controller.newItems.value!.length
                ? ItemBox(itemModel: controller.newItems.value![index])
                : Obx(
                    () => controller.isNewItemFetching.value
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: SizeConfig.sidePadding,
                              ),
                              child: MiniCircularIndicator(
                                color: elegantYellow,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
          ),
        );
      },
    );
  }
}
