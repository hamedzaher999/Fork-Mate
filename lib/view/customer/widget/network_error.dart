import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key, this.onTap, this.message});
  final VoidCallback? onTap;
  final String? message;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded, size: SizeConfig.fontRegular),
            SizedBox(height: SizeConfig.height * 0.01),
            Text(
              message?.tr ?? 'network error... tap to retry'.tr,
              style: TextStyle(fontSize: SizeConfig.fontXSmall),
            ),
          ],
        ),
      ),
    );
  }
}
