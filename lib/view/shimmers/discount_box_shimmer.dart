import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class DiscountBoxShimmer extends StatelessWidget {
  const DiscountBoxShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
        ),
        child: Container(width: SizeConfig.width * 0.18),
      ),
    );
  }
}
