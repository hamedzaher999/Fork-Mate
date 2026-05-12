import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/services_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/item_box.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:fork_mate/view/shimmers/item_box_shimmer.dart';

class ItemSection extends StatelessWidget {
  const ItemSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetX<ServicesController>(
            builder: (controller) {
              final serviceId = controller.currentService.value;
              final items = controller.checkItems(
                serviceId,
                controller.currentCategory.value[serviceId]!,
              );
              return SizedBox(
                height: SizeConfig.height,
                child: CustomScrollView(
                  controller: controller.verticalController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(top: SizeConfig.sidePaddingX2),
                    ),
                    // categories icons section
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: SizeConfig.height * 0.035,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller
                              .storedCategories
                              .value[serviceId]!
                              .length,
                          itemBuilder: (context, index) {
                            final category = controller
                                .storedCategories
                                .value[serviceId]![index];
                            return Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: SizeConfig.sidePadding,
                              ),
                              child: CustomButton(
                                title: category.title.tr,
                                fontSize: SizeConfig.fontSmall,
                                isSelected:
                                    category.id ==
                                    controller.currentCategory.value[serviceId],

                                onTap: () {
                                  controller.setCurrentCategory(
                                    serviceId,
                                    category.id,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // item display section
                    ...[
                      !controller.itemFetchingError.value
                          ? (items == null
                                ? SliverList(
                                    delegate: SliverChildBuilderDelegate((
                                      _,
                                      index,
                                    ) {
                                      return ItemBoxShimmer();
                                    }, childCount: 4),
                                  )
                                : items.isEmpty
                                ? SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Center(
                                      child: CenterMessage(
                                        message: 'Sold out.',
                                      ),
                                    ),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate((
                                      _,
                                      index,
                                    ) {
                                      return ItemBox(itemModel: items[index]);
                                    }, childCount: items.length),
                                  ))
                          : SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: NetworkError(
                                  onTap: () {
                                    controller.setCurrentCategory(
                                      serviceId,
                                      controller
                                          .currentCategory
                                          .value[serviceId]!,
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                    if (controller.isPagination.value)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: SizeConfig.sidePadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MiniCircularIndicator(color: elegantYellow),
                            ],
                          ),
                        ),
                      ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: SizeConfig.height * 0.12),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
