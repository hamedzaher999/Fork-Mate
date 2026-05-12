import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';

import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({super.key, this.radius});
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: elegantYellow,
          borderRadius: BorderRadius.circular(radius ?? SizeConfig.radius),
        ),
      ),
    );
  }
}
