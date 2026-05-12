import 'package:flutter/material.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/customer/widget/running_order_box.dart';
import 'package:fork_mate/view/shared_widget/waiting_indicator.dart';
import 'package:get/get.dart';

class CanceledOrdersSection extends StatelessWidget {
  const CanceledOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      builder: (controller) {
        final order = controller.canceledOrder.value;
        if (controller.canceledOrdersNetworkError.value) {
          return SliverFillRemaining(
            child: NetworkError(onTap: controller.getCanceledOrders),
          );
        }
        if (controller.canceledOrder.value == null) {
          return SliverFillRemaining(child: WaitingIndicator());
        }
        return controller.canceledOrder.value!.isEmpty
            ? SliverFillRemaining(
                child: CenterMessage(message: 'No Canceled Order'.tr),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate((_, index) {
                  return Padding(
                    padding: EdgeInsets.all(SizeConfig.sidePadding),
                    child: RunningOrderBox(order: order![index]),
                  );
                }, childCount: controller.canceledOrder.value!.length),
              );
      },
    );
  }
}
