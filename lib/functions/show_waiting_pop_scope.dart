import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/shared_widget/waiting_indicator.dart';
import 'package:get/get.dart';

Future<bool> showWaitingPopScope({String? message, bool canBack = true}) async {
  DateTime? lastBackPressed;
  final result = await Get.dialog<bool>(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && canBack) {
            final now = DateTime.now();
            if (lastBackPressed == null ||
                now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
              lastBackPressed = now;
              return;
            }
            Get.until((route) => route.isFirst);
            Get.back(result: true);
          }
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WaitingIndicator(),
                SizedBox(height: SizeConfig.sidePadding),
                Text(message?.tr ?? ''),
              ],
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
  return result ?? false;
}
