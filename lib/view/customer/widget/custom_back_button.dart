import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onBackCallback});
  final VoidCallback? onBackCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onBackCallback?.call();
        Get.back();
      },
      child: Container(
        width: SizeConfig.width * 0.1,
        height: SizeConfig.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radius / 1.5),
          color: elegantYellow,
        ),
        child: Center(
          child: Icon(
            color: black,
            Icons.arrow_forward_ios_rounded,
            size: SizeConfig.fontRegular,
          ),
        ),
      ),
    );
  }
}
