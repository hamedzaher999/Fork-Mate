import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountdownController extends GetxController {
  var remaining = Duration.zero.obs;
  Map<String, VoidCallback> callBackMap = {};
  Timer? timer;
  final String tag;

  void remainingTime(String timeString) {
    List<String> parts = timeString.split(":");
    if (parts.length == 4) {
      remaining.value = Duration(
        days: int.parse(parts[0]),
        hours: int.parse(parts[1]),
        minutes: int.parse(parts[2]),
        seconds: int.parse(parts[3]),
      );
    } else if (parts.length == 3) {
      remaining.value = Duration(
        hours: int.parse(parts[0]),
        minutes: int.parse(parts[1]),
        seconds: int.parse(parts[2]),
      );
    } else {
      remaining.value = Duration.zero;
    }
  }

  CountdownController({required String timeString, required this.tag}) {
    remainingTime(timeString);
  }

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remaining.value.inSeconds > 0) {
        remaining.value -= const Duration(seconds: 1);
      } else {
        timer?.cancel();
        for (final callback in callBackMap.values) {
          callback();
        }
        Get.delete<CountdownController>(tag: tag);
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String dayStr = d.inDays > 0 ? "${d.inDays}d " : "";
    return "$dayStr${twoDigits(d.inHours.remainder(24))}:"
        "${twoDigits(d.inMinutes.remainder(60))}:"
        "${twoDigits(d.inSeconds.remainder(60))}";
  }
}
