import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/pages/running_order_details_page.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get.dart';

class RunningOrderBox extends StatelessWidget {
  const RunningOrderBox({super.key, required this.order});
  final RunningOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      padding: EdgeInsets.all(SizeConfig.sidePadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('order status'.tr),
              Text('N: ${order.orderId.toString()} '),
              Text(
                order.orderStatus.tr,
                style: TextStyle(
                  color: order.orderStatus == 'Canceled' ? Colors.red : null,
                ),
              ),
            ],
          ),
          Divider(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('payment status'.tr),
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
            ],
          ),
          SizedBox(height: SizeConfig.sidePadding),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomButton(
              title: 'details'.tr,
              isSelected: true,
              onTap: () {
                Get.to(() => RunningOrderDetailsPage(order: order));
              },
            ),
          ),
        ],
      ),
    );
  }
}
