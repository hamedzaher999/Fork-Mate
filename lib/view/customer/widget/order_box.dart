import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/view/customer/pages/order_details_page.dart';
import 'package:fork_mate/view/customer/widget/editable_order_item_box.dart';
import 'package:fork_mate/view/customer/widget/order_gift_box.dart';
import 'package:fork_mate/view/customer/widget/order_offer_box.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/pages/edit_order_page.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';

class OrderBox extends GetView<CartController> {
  const OrderBox({super.key, required this.orderId});
  final int orderId;
  @override
  Widget build(BuildContext context) {
    final order = controller.cart[orderId];
    final orderItems = order!.items.entries
        .expand((outerEntry) => outerEntry.value.entries)
        .toList();
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.sidePadding),
      child: GestureDetector(
        onTap: () {
          Get.to(() => EditOrderPage(orderId: orderId))?.then((_) {
            controller.fixCart();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            boxShadow: shadow,
            borderRadius: BorderRadius.circular(SizeConfig.radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.sidePadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('order'.tr),
                    Text('$orderId'),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => EditOrderPage(orderId: orderId));
                          },
                          child: Icon(CupertinoIcons.pen, color: elegantYellow),
                        ),
                        SizedBox(width: SizeConfig.sidePadding),
                        GestureDetector(
                          onTap: () async {
                            if (await confirmationDialog(
                              message: 'تأكيد حذف الطلب'.tr,
                            )) {
                              Get.find<CartController>().removeOrderFromCart(
                                orderId,
                              );
                            }
                          },
                          child: Icon(
                            CupertinoIcons.delete,
                            color: elegantYellow,
                            size: SizeConfig.fontRegular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //items
                Divider(),
                if (orderItems.isNotEmpty) ...[
                  ...orderItems.map((item) {
                    return EditableOrderItemBox(
                      itemModel: item.value,
                      itemKey: item.key,
                      orderId: orderId,
                    );
                  }),
                  Divider(),
                ],
                //offers
                if (order.offers.isNotEmpty) ...[
                  ...order.offers.values.map(
                    (offer) =>
                        OrderOfferBox(orderId: orderId, offerModel: offer),
                  ),
                  Divider(),
                ],
                //gifts
                if (order.gifts.isNotEmpty) ...[
                  ...order.gifts.values.map(
                    (giftModel) =>
                        OrderGiftBox(orderId: orderId, giftModel: giftModel),
                  ),
                  Divider(),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total'.tr,
                      style: TextStyle(fontSize: SizeConfig.fontSmall),
                    ),
                    Text(
                      formatPrice(order.orderPrice()),
                      style: TextStyle(
                        fontSize: SizeConfig.fontSmall,
                        color: Colors.green,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: CustomButton(
                    title: 'order',
                    isSelected: true,
                    fontSize: SizeConfig.fontXSmall,
                    onTap: () async {
                      Get.putAsync(
                        () => OrderDetailsController().create(order, orderId),
                      );
                      Get.to(OrderDetailsPage());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
