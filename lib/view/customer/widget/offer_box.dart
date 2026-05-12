import 'package:flutter/material.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/controller/offer_customizer_controller.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/view/customer/pages/customize_offer_page.dart';
import 'package:fork_mate/view/customer/widget/countdown_timer.dart';
import 'package:fork_mate/view/customer/widget/one_line_note.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/offer_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/sticker.dart';

class OfferBox extends StatelessWidget {
  const OfferBox({super.key, required this.offer});
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.putAsync(
          permanent: false,
          () => OfferCustomizerController().create(
            offer.clone(),
            remainingTime: Get.find<CountdownController>(
              tag: offer.tag,
            ).remaining.toString().split('.')[0],
          ),
        );
        Get.to(() => CustomizeOfferPage());
      },
      child: Container(
        width: SizeConfig.width * 0.75,
        decoration: BoxDecoration(
          boxShadow: shadow,
          color: mainColor,
          borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                child: Padding(
                  padding: EdgeInsets.only(bottom: SizeConfig.sidePaddingX2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.width * 0.6,
                        child: Text(
                          offer.name,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: elegantYellow,
                            fontSize: SizeConfig.fontMedium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: SizeConfig.width * 0.01),
                      Text(
                        offer.description,
                        maxLines: 2,
                        style: TextStyle(fontSize: SizeConfig.fontXSmall),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              PositionedDirectional(
                bottom: SizeConfig.sidePadding / 2,
                end: SizeConfig.sidePadding,
                start: SizeConfig.sidePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OneLineNote(
                      note: ['Price', '  ', formatPrice(offer.price)],
                      color: Colors.green,
                    ),
                    CountdownTimer(tag: offer.tag),
                  ],
                ),
              ),
              Sticker(decoration: true, shimmer: true),
            ],
          ),
        ),
      ),
    );
  }
}
