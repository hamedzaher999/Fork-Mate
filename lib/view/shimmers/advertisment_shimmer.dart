import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';

import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class AdvertisementShimmer extends StatelessWidget {
  const AdvertisementShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.sidePadding),
        child: Container(
          height: SizeConfig.height * 0.2,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
          ),
        ),
      ),
    );
  }
}
