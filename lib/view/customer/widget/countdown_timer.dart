import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/utils/size_config.dart';

class CountdownTimer extends StatelessWidget {
  CountdownTimer({
    super.key,
    this.fontSize,
    this.icon = true,
    this.color,
    required this.tag,
  }) : controller = Get.isRegistered<CountdownController>(tag: tag)
           ? Get.find<CountdownController>(tag: tag)
           : null;

  final bool icon;
  final Color? color;
  final double? fontSize;
  final String tag;
  final CountdownController? controller;
  @override
  Widget build(BuildContext context) {
    return controller == null
        ? Icon(
            Icons.ac_unit_sharp,
            size: SizeConfig.fontSmall,
            color: Colors.blue,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon) ...[
                Icon(
                  Icons.timelapse_rounded,
                  color: Colors.red,
                  size: SizeConfig.fontSmall,
                ),
                SizedBox(width: SizeConfig.width * 0.025),
              ],
              Obx(
                () => Text(
                  controller!.formatDuration(controller!.remaining.value),
                  style: TextStyle(
                    height: 1,
                    color: color,
                    fontSize: fontSize ?? SizeConfig.fontXSmall,
                  ),
                ),
              ),
            ],
          );
  }
}
