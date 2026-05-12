import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

void createSnackBar({
  String? message,
  int? milliSecondDuration,
  Color? textColor,
  bool networkError = false,
  bool error = false,
}) {
  try {
    if (Get.isSnackbarOpen) {
      return;
    }
    Get.snackbar(
      '',
      '',
      // backgroundColor: elegantYellow.withAlpha(140),
      backgroundColor: mainColor.withAlpha(140),
      messageText: Text(
        networkError
            ? 'network error, please try again'.tr
            : error
            ? 'something went wrong, please try again'.tr
            : message?.tr ?? "",
        style: TextStyle(fontSize: SizeConfig.fontXSmall, color: textColor),
      ),
      duration: Duration(milliseconds: milliSecondDuration ?? 2000),
    );
  } catch (_) {
    return;
  }
}
