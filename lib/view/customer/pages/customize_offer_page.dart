import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/offer_customizer_controller.dart';
import 'package:fork_mate/view/customer/widget/countdown_timer.dart';
import 'package:fork_mate/view/customer/widget/count_control_panel.dart';
import 'package:get/get.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/bottom_sheet.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';

class CustomizeOfferPage extends GetView<OfferCustomizerController> {
  const CustomizeOfferPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(),
      body: SizedBox(
        height: SizeConfig.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.offerModel.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: elegantYellow,
                          fontSize: SizeConfig.fontRegular,
                        ),
                      ),
                      SizedBox(height: SizeConfig.sidePadding),
                      Text(controller.offerModel.description),
                      SizedBox(height: SizeConfig.sidePadding),
                      Divider(),
                      SizedBox(height: SizeConfig.sidePadding),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: SizeConfig.fontXSmall / 2,
                            color: Colors.green,
                          ),
                          SizedBox(width: SizeConfig.sidePadding),
                          Text(
                            'offer price'.tr,
                            style: TextStyle(fontSize: SizeConfig.fontSmall),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: SizeConfig.sidePadding),
                          Text(
                            controller.offerModel.price.toString(),
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: SizeConfig.fontSmall,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.sidePadding),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: SizeConfig.fontXSmall / 2,
                            color: Colors.red,
                          ),
                          SizedBox(width: SizeConfig.sidePadding),
                          Text(
                            'time left'.tr,
                            style: TextStyle(fontSize: SizeConfig.fontSmall),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: SizeConfig.sidePadding),
                          CountdownTimer(
                            tag: controller.offerModel.tag,
                            icon: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //---
            CustomBottomSheet(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.height * 0.01),
                  GetBuilder<OfferCustomizerController>(
                    builder: (controller) {
                      return CountControlPanel(
                        increment: controller.increment,
                        decrement: controller.decrement,
                        clear: controller.clear,
                        count: controller.offerModel.count,
                        price: controller.offerModel.getTotalPrice(),
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
        ),
      ),
    );
  }
}
