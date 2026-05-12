import 'package:flutter/material.dart';
import 'package:fork_mate/view/customer/fork_indicator.dart';
import 'package:get/get.dart';
import 'package:fork_mate/utils/size_config.dart';

class WaitingIndicator extends StatelessWidget {
  const WaitingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(child: ForkIndicator()),
            SizedBox(height: SizeConfig.verticalSpace * 4),
            Text('please wait...'.tr),
          ],
        ),
      ],
    );
  }
}
