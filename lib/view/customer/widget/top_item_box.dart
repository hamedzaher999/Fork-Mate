import 'package:flutter/material.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/controller/item_customizer_controller.dart.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/pages/customize_item_page.dart';
import 'package:fork_mate/view/customer/widget/network_image_container.dart';
import 'package:fork_mate/view/customer/widget/sticker.dart';

//
class TopItemBox extends StatelessWidget {
  const TopItemBox({super.key, required this.itemModel});
  final ItemModel itemModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.width * 0.18,
      child: Column(
        children: [
          GestureDetector(
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
              decoration: BoxDecoration(
                color: imagePlaceHolderColor,
                boxShadow: shadow,
                borderRadius: BorderRadius.circular(SizeConfig.radius * 1.2),
              ),
              child: Stack(
                children: [
                  NetworkImageContainer(
                    radius: SizeConfig.radius * 1.2,
                    imageURL: itemModel.image,
                    width: SizeConfig.width * 0.18,
                    height: SizeConfig.width * 0.18,
                  ),
                  if (itemModel.discount != null)
                    Sticker(
                      color: const Color.fromARGB(173, 0, 255, 4),
                      text: 'offer'.tr,
                      shimmer: true,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.sidePadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(MdiIcons.star, color: stars, size: SizeConfig.fontMedium),
                SizedBox(width: SizeConfig.width * 0.02),
                Text(
                  itemModel.rate,
                  style: TextStyle(fontSize: SizeConfig.fontSmall, height: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
