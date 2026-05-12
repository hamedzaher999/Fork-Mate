import 'package:flutter/material.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/view/customer/pages/order_details_page.dart';
import 'package:fork_mate/view/customer/widget/order_gift_box.dart';
import 'package:fork_mate/view/customer/widget/order_offer_box.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/bottom_sheet.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/editable_order_item_box.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';

class EditOrderPage extends GetView<CartController> {
  const EditOrderPage({super.key, required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        title: 'Edit order',
        onBackCallBack: () {
          Get.back();
          controller.fixCart();
        },
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          if (controller.cart[orderId] == null) {
            return CenterMessage(message: 'deleted order');
          }
          final orderItems = controller.expandItem(orderId);
          final offers = controller.cart[orderId]!.offers;
          final gifts = controller.cart[orderId]!.gifts;
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                child: CustomScrollView(
                  slivers: [
                    GetBuilder<CartController>(
                      builder: (controller) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return EditableOrderItemBox(
                              orderId: orderId,
                              itemModel: orderItems[index].value,
                              itemKey: orderItems[index].key,
                              editable: true,
                            );
                          }, childCount: orderItems.length),
                        );
                      },
                    ),
                    GetBuilder<CartController>(
                      builder: (controller) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return OrderOfferBox(
                              orderId: orderId,
                              offerModel: offers.values.toList()[index],
                              editable: true,
                            );
                          }, childCount: offers.length),
                        );
                      },
                    ),

                    GetBuilder<CartController>(
                      builder: (controller) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return OrderGiftBox(
                              orderId: orderId,
                              giftModel: gifts.values.toList()[index],
                              editable: true,
                            );
                          }, childCount: gifts.length),
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomBottomSheet(
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.sidePadding),
                  child: Column(
                    children: [
                      GetBuilder<CartController>(
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "item count".tr,
                                    style: TextStyle(
                                      fontSize: SizeConfig.fontMedium,
                                    ),
                                  ),
                                  SizedBox(width: SizeConfig.width * 0.03),
                                  Text(
                                    controller.cart[orderId]!
                                        .itemCount()
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.fontMedium,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                formatPrice(
                                  controller.cart[orderId]!.orderPrice(),
                                ),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.fontMedium,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: SizeConfig.height * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            title: 'delete order',
                            hasShadow: false,
                            isSelected: true,
                            onTap: () async {
                              if (await confirmationDialog(
                                message:
                                    'are you sure you want to delete this order',
                              )) {
                                Get.back();
                                controller.removeOrderFromCart(orderId);
                              }
                            },
                          ),
                          CustomButton(
                            hasShadow: false,
                            title: 'order',
                            isSelected: true,
                            onTap: () {
                              controller.cart[orderId]?.fixOrder();
                              controller.update();
                              Get.putAsync(
                                () => OrderDetailsController().create(
                                  controller.cart[orderId]!,
                                  orderId,
                                ),
                              );
                              Get.to(OrderDetailsPage());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
