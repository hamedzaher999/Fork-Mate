import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/notifications_controller.dart';
import 'package:fork_mate/view/sections/canceled_orders_ection.dart';
import 'package:fork_mate/view/sections/running_orders_section.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/custom_app_bar.dart';
import 'package:fork_mate/view/customer/widget/order_box.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        child: GetBuilder<CartController>(
          builder: (controller) {
            List<int> itemsKeys = controller.cart.keys.toList();
            return RefreshIndicator(
              onRefresh: controller.refreshPage,
              color: elegantYellow,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: SizeConfig.width,
                      height: SizeConfig.height * 0.03,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: orderStatus.length,
                        itemBuilder: (_, index) => Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: SizeConfig.sidePadding,
                          ),
                          child: GetX<NotificationsController>(
                            builder: (notificationsController) {
                              return CustomButton(
                                title: orderStatus[index],
                                isSelected:
                                    controller.type == orderStatus[index],
                                onTap: () {
                                  controller.setType(orderStatus[index]);
                                },
                                notification:
                                    (notificationsController
                                            .hasRunningOrders
                                            .value &&
                                        orderStatus[index] == orderStatus[1]) ||
                                    (notificationsController
                                            .hasCanceledOrders
                                            .value &&
                                        orderStatus[index] == orderStatus[2]),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  //pending order section
                  if (controller.type == 'Pending')
                    itemsKeys.isEmpty
                        ? SliverFillRemaining(
                            child: CenterMessage(message: 'No Pending Orders'),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return OrderBox(orderId: itemsKeys[index]);
                            }, childCount: itemsKeys.length),
                          ),

                  //In Progress order section
                  if (controller.type == 'In Progress') RunningOrdersSection(),

                  //Canceled order section
                  if (controller.type == 'Canceled') CanceledOrdersSection(),
                  SliverPadding(
                    padding: EdgeInsets.only(top: SizeConfig.height * 0.1),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
