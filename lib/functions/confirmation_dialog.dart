import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';

Future<bool> confirmationDialog({
  required String message,
  String? confirmText,
  bool showAlert = true,
  bool actions = true,
}) async {
  final result = await Get.dialog<bool>(
    AlertDialog(
      title: showAlert
          ? Text('alert'.tr, style: TextStyle(color: Colors.red))
          : null,
      content: Text(
        message.tr,
        style: TextStyle(fontSize: SizeConfig.fontXSmall),
      ),
      actions: actions
          ? [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text('cancel'.tr, style: TextStyle(color: xMainColor)),
              ),
              ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: Text(
                  confirmText?.tr ?? 'ok'.tr,
                  style: TextStyle(color: xMainColor),
                ),
              ),
            ]
          : null,
    ),
  );

  return result ?? false;
}
