import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get.dart';

Future<void> showDelayDialog(String title, int seconds) async {
  Get.dialog(
    Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.sidePadding),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                title.tr,
                style: TextStyle(fontSize: SizeConfig.fontSmall),
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
  await Future.delayed(Duration(seconds: seconds));
  Get.back();
}
