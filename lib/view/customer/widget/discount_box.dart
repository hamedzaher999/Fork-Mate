import 'package:flutter/material.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/controller/item_customizer_controller.dart.dart';
import 'package:fork_mate/view/customer/widget/countdown_timer.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/pages/customize_item_page.dart';
import 'package:fork_mate/view/customer/widget/network_image_container.dart';

class DiscountBox extends StatelessWidget {
  const DiscountBox({super.key, required this.itemModel});
  final ItemModel itemModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final CountdownController? timer;
        if (Get.isRegistered<CountdownController>(tag: itemModel.tag)) {
          timer = Get.find<CountdownController>(tag: itemModel.tag);
        } else {
          timer = null;
        }
        Get.putAsync(
          () => ItemCustomizerController().create(
            itemModel.clone(),
            remainingTime: timer?.remaining.toString().split('.')[0],
          ),
        );
        Get.to(() => CustomizeItemPage());
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.sidePadding / 1.5),
        decoration: BoxDecoration(
          boxShadow: shadow,
          color: mainColor,
          borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NetworkImageContainer(
              imageURL: itemModel.image,
              radius: SizeConfig.radius * 1.2,
              width: SizeConfig.width * 0.18,
              height: SizeConfig.width * 0.18,
            ),
            Center(
              child: Text(
                '${itemModel.discount!.discount} %',
                style: TextStyle(color: Colors.green),
              ),
            ),
            if (itemModel.discount != null)
              CountdownTimer(tag: itemModel.tag, icon: false),
          ],
        ),
      ),
    );
  }
}
