import 'package:flutter/material.dart';
import 'package:fork_mate/view/customer/widget/count_control_panel.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/item_customizer_controller.dart.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/sections/item_key_details_section.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/bottom_sheet.dart';
import 'package:fork_mate/view/customer/widget/network_image_container.dart';
import 'package:fork_mate/view/customer/widget/ingredients_box.dart';
import 'package:fork_mate/view/customer/widget/preferences_box.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';

class CustomizeItemPage extends GetView<ItemCustomizerController> {
  const CustomizeItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title: ''),
      body: SizedBox(
        height: SizeConfig.height,
        child: GetBuilder<ItemCustomizerController>(
          id: 'updated',
          builder: (controller) {
            final itemModel = controller.itemModel;
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: SizeConfig.sidePadding,
                    left: SizeConfig.sidePadding,
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: SizeConfig.height * 0.18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NetworkImageContainer(
                              imageURL: itemModel.image,
                              width: SizeConfig.width,
                              height: SizeConfig.height * .3,
                            ),
                          ],
                        ),
                        //details section
                        ItemKeyDetailsSection(),
                        Divider(),
                        // ingredient  section
                        IngredientsBox(),
                        SizedBox(height: SizeConfig.height * 0.01),
                        //preference section
                        GetBuilder<ItemCustomizerController>(
                          builder: (orderController) {
                            return SizedBox(
                              width: SizeConfig.width,
                              child: Wrap(
                                children: itemModel.preferences.map((
                                  preference,
                                ) {
                                  return PreferencesBox(
                                    preferencesModel: preference,
                                    itemModel: orderController.itemModel,
                                    size: SizeConfig.fontMedium,
                                    callback: orderController.update,
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                CustomBottomSheet(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.height * 0.01),
                      GetBuilder<ItemCustomizerController>(
                        builder: (controller) {
                          return CountControlPanel(
                            increment: controller.increment,
                            decrement: controller.decrement,
                            clear: controller.clear,
                            count: controller.itemModel.count,
                            price: controller.itemModel.getTotalPrice(),
                          );
                        },
                      ),
                      SizedBox(height: SizeConfig.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            title: 'order',
                            hasShadow: false,
                            isSelected: true,
                            onTap: () {
                              controller.directOrder();
                            },
                          ),
                          CustomButton(
                            title: 'add to order',
                            hasShadow: false,
                            isSelected: true,
                            onTap: () {
                              controller.addItemToOrder();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
