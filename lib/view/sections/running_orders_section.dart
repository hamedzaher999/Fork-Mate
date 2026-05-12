import 'package:flutter/material.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/customer/widget/running_order_box.dart';
import 'package:fork_mate/view/shared_widget/waiting_indicator.dart';
import 'package:get/get.dart';

class RunningOrdersSection extends StatelessWidget {
  const RunningOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      builder: (controller) {
        final order = controller.inProgressOrder.value;
        if (controller.runningOrdersNetworkError.value) {
          return SliverFillRemaining(
            child: NetworkError(onTap: controller.getInProgressOrders),
          );
        }
        if (controller.inProgressOrder.value == null) {
          return SliverFillRemaining(child: WaitingIndicator());
        }
        return controller.inProgressOrder.value!.isEmpty
            ? SliverFillRemaining(
                child: CenterMessage(message: 'No Running order'.tr),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate((_, index) {
                  return Padding(
                    padding: EdgeInsets.all(SizeConfig.sidePadding),
                    child: RunningOrderBox(order: order![index]),
                  );
                }, childCount: controller.inProgressOrder.value!.length),
              );
      },
    );
  }
}
