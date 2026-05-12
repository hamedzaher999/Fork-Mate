import 'package:flutter/material.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/controller/item_customizer_controller.dart.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/view/customer/widget/countdown_timer.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/pages/customize_item_page.dart';
import 'package:fork_mate/view/customer/widget/network_image_container.dart';
import 'package:fork_mate/view/customer/widget/sticker.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({super.key, required this.itemModel});
  final ItemModel itemModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.sidePadding,
        left: SizeConfig.sidePadding,
        right: SizeConfig.sidePadding,
      ),
      child: GestureDetector(
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
            color: mainColor,
            boxShadow: shadow,
            borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.sidePadding,
                  ),
                  child: SizedBox(
                    height: SizeConfig.width * 0.18,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.sidePadding,
                          ),
                          child: NetworkImageContainer(
                            imageURL: itemModel.image,
                            radius: SizeConfig.radius * 1.2,
                            width: SizeConfig.width * 0.18,
                            height: SizeConfig.width * 0.18,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                itemModel.name,
                                style: TextStyle(
                                  color: elegantYellow,
                                  fontSize: SizeConfig.fontSmall,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    formatPrice(
                                      itemModel.getPriceAfterDiscount(),
                                    ),
                                    style: TextStyle(
                                      fontSize: SizeConfig.fontSmall,
                                    ),
                                  ),
                                  SizedBox(width: SizeConfig.sidePadding),
                                  if (itemModel.discount != null)
                                    Text(
                                      formatPrice(itemModel.price),
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        decorationThickness: 2,
                                        fontSize: SizeConfig.fontXSmall,
                                      ),
                                    ),
                                ],
                              ),

                              Align(
                                child: Row(
                                  mainAxisAlignment: itemModel.discount != null
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.end,
                                  children: [
                                    if (itemModel.discount != null)
                                      CountdownTimer(tag: itemModel.tag),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: SizeConfig.sidePadding,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        textBaseline: TextBaseline.ideographic,
                                        children: [
                                          Text(
                                            itemModel.rate,
                                            style: TextStyle(
                                              fontSize: SizeConfig.fontXSmall,
                                            ),
                                            strutStyle: StrutStyle(
                                              forceStrutHeight: true,
                                              height: 1.0,
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConfig.width * 0.02,
                                          ),
                                          Icon(
                                            Icons.star_rate_rounded,
                                            color: stars,
                                            size: SizeConfig.fontMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (itemModel.discount != null)
                  Sticker(
                    color: const Color.fromARGB(173, 0, 255, 4),
                    text: 'offer',
                    shimmer: true,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
