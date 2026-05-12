import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class OfferBoxShimmer extends StatelessWidget {
  const OfferBoxShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        child: Container(
          width: SizeConfig.width * 0.75,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
          ),
        ),
      ),
    );
  }
}
