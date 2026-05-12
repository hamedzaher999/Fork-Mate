import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class Sticker extends StatelessWidget {
  const Sticker({
    super.key,
    this.color,
    this.text,
    this.decoration = false,
    this.shimmer = false,
  });
  final Color? color;
  final bool decoration;
  final String? text;
  final bool shimmer;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 10,
      end: -20,
      child: Transform.rotate(
        angle: Get.locale?.languageCode == 'ar'
            ? -45 * pi / 180
            : 45 * pi / 180,
        child: Stack(
          children: [
            Shimmer.fromColors(
              enabled: shimmer,
              period: const Duration(seconds: 2),
              baseColor: color ?? elegantYellow,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: decoration ? shadow : null,
                ),
                width: SizeConfig.width * 0.2,
                height: SizeConfig.width * 0.045,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Align(
                child: Text(
                  text?.tr ?? '',
                  style: TextStyle(
                    color: black,
                    fontSize: SizeConfig.fontXSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return PositionedDirectional(
    //   top: 10,
    //   end: -20,
    //   child: Transform.rotate(
    //     angle: Get.locale?.languageCode == 'ar'
    //         ? -45 * pi / 180
    //         : 45 * pi / 180,
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: color ?? elegantYellow,
    //         boxShadow: decoration ? shadow : null,
    //       ),
    //       width: SizeConfig.width * 0.2,
    //       height: SizeConfig.width * 0.05,
    //       child: Center(
    //         child: Text(
    //           text ?? ''.tr,
    //           style: TextStyle(fontSize: SizeConfig.fontXSmall),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
