import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/offer_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/counter.dart';
import 'package:get/get.dart';

class OrderOfferBox extends GetView<CartController> {
  const OrderOfferBox({
    super.key,
    required this.orderId,
    required this.offerModel,
    this.editable = false,
  });
  final bool editable;
  final OfferModel offerModel;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: editable ? SizeConfig.sidePadding : 0),

      child: Container(
        decoration: editable ? boxDecoration : null,
        padding: EdgeInsets.all(editable ? SizeConfig.sidePadding : 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: SizeConfig.fontXSmall / 2,
                      color: elegantYellow,
                    ),
                    SizedBox(width: SizeConfig.sidePadding),

                    Text(offerModel.name),
                    SizedBox(width: SizeConfig.sidePadding),

                    if (!editable) Text(offerModel.count.toString()),
                  ],
                ),
                Text(formatPrice((offerModel.getTotalPrice()))),
              ],
            ),

            if (editable) ...[
              SizedBox(height: SizeConfig.sidePadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Counter(
                    count: offerModel.count,
                    increment: () {
                      offerModel.increment();
                      controller.update();
                    },
                    decrement: () {
                      offerModel.decrement();
                      controller.update();
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.cart[orderId]!.removeOffer(offerModel.id);
                      controller.update();
                    },
                    child: Icon(Icons.delete, color: elegantYellow),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
