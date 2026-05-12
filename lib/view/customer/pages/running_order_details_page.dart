import 'package:flutter/material.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/format_date.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/bottom_sheet.dart';
import 'package:fork_mate/view/customer/widget/delivery_details_box.dart';
import 'package:fork_mate/view/customer/widget/order_content_box.dart';
import 'package:fork_mate/view/customer/widget/payment_details_box.dart';
import 'package:fork_mate/view/sections/running_order_notes_section.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

class RunningOrderDetailsPage extends StatelessWidget {
  const RunningOrderDetailsPage({super.key, required this.order});
  final RunningOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title: 'N: ${order.orderId.toString()} '),
      body: SizedBox(
        height: SizeConfig.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //order status details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('order status'.tr),
                        Text(
                          order.orderStatus.tr,
                          style: TextStyle(
                            color: order.orderStatus == 'Canceled'
                                ? Colors.red
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.sidePadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('final price'.tr),
                        Text(
                          formatPrice(order.finalPrice),
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.sidePadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('payment method'.tr),
                        Text(order.paymentDetails.paymentMethod.tr),
                      ],
                    ),

                    if (order.cancelMessage != null) ...[
                      Divider(),
                      SizedBox(height: SizeConfig.sidePadding / 2),
                      Text(
                        'cancellation reason'.tr,
                        style: TextStyle(fontSize: SizeConfig.fontSmall),
                      ),
                      Text(
                        order.cancelMessage!,
                        style: TextStyle(fontSize: SizeConfig.fontXSmall),
                      ),
                    ],
                    Divider(),
                    SizedBox(height: SizeConfig.sidePadding),
                    Text(
                      'details'.tr,
                      style: TextStyle(fontSize: SizeConfig.fontMedium),
                    ),
                    SizedBox(height: SizeConfig.sidePadding),
                    // order content
                    OrderContentBox(order: order),
                    SizedBox(height: SizeConfig.sidePadding),
                    // delivery details
                    DeliveryDetailsBox(order: order),
                    SizedBox(height: SizeConfig.sidePadding),
                    // payment details
                    PaymentDetailsBox(order: order),
                    SizedBox(height: SizeConfig.sidePadding),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.sidePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('order at'.tr),
                              SizedBox(width: SizeConfig.sidePadding),
                              Text(
                                formatDate(order.createdAt),
                                style: TextStyle(
                                  fontSize: SizeConfig.fontXSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.sidePadding / 2),

                          Row(
                            children: [
                              Text('delivered at'.tr),
                              SizedBox(width: SizeConfig.sidePadding),

                              Text(
                                order.deliveredAt != null
                                    ? formatDate(order.deliveredAt!.tr)
                                    : '.....',
                                style: TextStyle(
                                  fontSize: SizeConfig.fontXSmall,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    if (!order.isGift)
                      //additional details and notes
                      RunningOrderNotesSection(order: order),
                    SizedBox(height: SizeConfig.height * 0.1),
                  ],
                ),
              ),
            ),
            if (order.canCancel)
              CustomBottomSheet(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.sidePadding,
                    vertical: SizeConfig.sidePadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Text(
                            maxLines: 2,
                            "You can cancel the order as long as its preparation hasn't started yet"
                                .tr,

                            style: TextStyle(fontSize: SizeConfig.fontXSmall),
                          ),
                        ),
                      ),
                      CustomButton(
                        title: 'cancel order',
                        isSelected: true,
                        onTap: () {
                          if (order.canCancel) {
                            Get.find<CartController>().cancelOrder(
                              order.orderId,
                            );
                          } else {
                            createSnackBar(
                              message:
                                  "Sorry, you can't cancel the order, it's already being prepared.",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
