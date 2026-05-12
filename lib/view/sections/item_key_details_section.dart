import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/view/customer/widget/countdown_timer.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/item_customizer_controller.dart.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/shared_widget/rate_stars.dart';

class ItemKeyDetailsSection extends GetView<ItemCustomizerController> {
  const ItemKeyDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final item = controller.itemModel;
    return SizedBox(
      width: SizeConfig.width,
      child: Stack(
        children: [
          Positioned(
            top: SizeConfig.height * 0.008,
            left: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.rate,
                  style: TextStyle(
                    fontSize: SizeConfig.fontMedium,
                    height: 0.8,
                  ),
                ),
                SizedBox(width: SizeConfig.width * 0.02),
                Icon(
                  CupertinoIcons.star_fill,
                  color: stars,
                  size: SizeConfig.fontRegular,
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentGeometry.center,
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.width * 0.45,
                  height: SizeConfig.height * 0.3 * 0.15,
                  child: RateStars(rate: item.myRate),
                ),
                SizedBox(height: SizeConfig.height * 0.015),

                SizedBox(
                  width: SizeConfig.width,
                  child: Text(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    item.name,
                    style: TextStyle(
                      fontSize: SizeConfig.fontXLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                item.discount != null
                    ? Column(
                        children: [
                          Text(
                            formatPrice(item.price),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2,
                              fontSize: SizeConfig.fontMedium,
                            ),
                          ),
                          Text(
                            formatPrice(item.getPriceAfterDiscount()),
                            style: TextStyle(fontSize: SizeConfig.fontLarge),
                          ),
                        ],
                      )
                    : Text(
                        formatPrice(item.price),
                        style: TextStyle(fontSize: SizeConfig.fontLarge),
                      ),
                if (item.discount != null)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CountdownTimer(tag: item.tag),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
