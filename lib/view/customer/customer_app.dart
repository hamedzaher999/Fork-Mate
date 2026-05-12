import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/floating_bottom_bar/floating_bottom_bar_controller.dart';
import 'package:fork_mate/view/floating_bottom_bar/floating_bottom_bar_view.dart';

class CustomerApp extends GetView<FloatingBottomBarController> {
  const CustomerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: Pages.values.length,
            itemBuilder: (context, index) {
              return Pages.values[index].page;
            },
          ),
          Positioned(
            bottom: SizeConfig.height * 0.01,
            left: 0,
            right: 0,
            child: FloatingBottomBar(),
          ),
        ],
      ),
    );
  }
}
