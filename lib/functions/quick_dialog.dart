import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/utils/size_config.dart';

void showQuickDialog(double message) {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }

  Get.dialog(
    Center(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(SizeConfig.radius),
        ),
        child: Text(
          " ${message >= 0 ? "+" : "-"} ${message.abs()}",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
            fontSize: SizeConfig.fontMedium,
          ),
        ),
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.transparent,
  );

  Future.delayed(Duration(milliseconds: 600), () {
    if (Get.isDialogOpen ?? false) Get.back();
  });
}
