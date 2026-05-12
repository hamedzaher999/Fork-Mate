import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/one_line_note.dart';
import 'package:fork_mate/view/customer/widget/sticker.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PaymentDetailsBox extends StatelessWidget {
  const PaymentDetailsBox({super.key, required this.order});
  final RunningOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.radius),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(SizeConfig.sidePadding),

              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('payment status'.tr),
                          if (!order.isGift)
                            Text(
                              order.orderPaymentStatus.tr,
                              style: TextStyle(
                                color: order.orderPaymentStatus == "paid"
                                    ? Colors.blue
                                    : Colors.red,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.sidePadding / 2),
                      if (order.deliveryDetails.method == 'delivery' &&
                          order.deliveryDetails.details != null)
                        Column(
                          children: [
                            OneLineNote(
                              note: [
                                'order coast',
                                ':',
                                order.orderPaymentStatus,
                              ],
                              color: order.orderPaymentStatus == "paid"
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                            OneLineNote(
                              note: [
                                'delivery coast'.tr,
                                ':',
                                order.deliveryDetails.deliveryPaymentStatus,
                              ],
                              color:
                                  order.deliveryDetails.deliveryPaymentStatus ==
                                      "paid"
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (order.isGift)
              Sticker(color: Colors.blue, shimmer: true, text: 'free'),
          ],
        ),
      ),
    );
  }
}
