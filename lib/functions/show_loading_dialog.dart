import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

void showLoadingDialog() {
  Get.dialog(
    PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back();
        }
      },
      child: Dialog(
        elevation: 0,
        child: SizedBox(
          height: SizeConfig.height * 0.15,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.sidePaddingX2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: elegantYellow),
                  SizedBox(height: SizeConfig.height * 0.02),
                  Text('please wait...'.tr),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
