import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';

import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class ButtonShimmer extends StatelessWidget {
  const ButtonShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: SizeConfig.sidePadding),
        child: GestureDetector(
          child: Container(
            width: SizeConfig.width * 0.2,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(
                SizeConfig.width * 0.08 * 0.35,
              ),
            ),
            child: SizedBox(
              height: SizeConfig.width * 0.08,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.sidePadding * 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
