import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/models/customer/customer_gift_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderGiftBox extends GetView<CartController> {
  const OrderGiftBox({
    super.key,
    required this.orderId,
    required this.giftModel,
    this.editable = false,
  });
  final int orderId;
  final CustomerGiftModel giftModel;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: editable ? SizeConfig.sidePadding : 0),
      child: Container(
        padding: EdgeInsets.all(editable ? SizeConfig.sidePadding : 0),
        decoration: editable ? boxDecoration : null,
        child: Row(
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
                Text("gift number"),
                SizedBox(width: SizeConfig.sidePadding),
                Text(giftModel.giftNumber.toString()),
              ],
            ),
            if (editable)
              GestureDetector(
                onTap: () {
                  controller.cart[orderId]!.removeGift(giftModel.id);
                  controller.update();
                },
                child: Icon(Icons.delete, color: elegantYellow),
              ),
          ],
        ),
      ),
    );
  }
}
