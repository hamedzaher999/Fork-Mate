import 'package:flutter/material.dart';
import 'package:fork_mate/controller/benefits_controller.dart';
import 'package:get/get.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/gift_box.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/shared_widget/waiting_indicator.dart';

class GiftsPage extends StatelessWidget {
  GiftsPage({super.key});
  final BenefitsController controller = Get.put(BenefitsController());

  @override
  Widget build(BuildContext context) {
    controller.fetchGifts();
    return Scaffold(
      appBar: BackAppBar(
        title: 'Gifts',
        onBackCallBack: () {
          controller.gifts.value = null;
        },
      ),
      body: GetX<BenefitsController>(
        builder: (controller) {
          if (controller.giftsFetchingError.value) {
            return NetworkError(
              onTap: () {
                controller.fetchGifts();
              },
            );
          }
          if (controller.gifts.value == null) {
            return WaitingIndicator();
          }
          if (controller.gifts.value!.isEmpty) {
            return CenterMessage(message: 'you dont have any gift'.tr);
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.sidePadding),
                  child: Text(
                    'Use the gift number and your username when ordering directly from the restaurant to receive your gift.'
                        .tr,
                    style: TextStyle(fontSize: SizeConfig.fontXSmall),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.gifts.value!.length,
                  (context, index) {
                    return GiftBox(giftModel: controller.gifts.value![index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
