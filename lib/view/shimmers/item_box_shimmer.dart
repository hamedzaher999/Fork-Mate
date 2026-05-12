import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class ItemBoxShimmer extends StatelessWidget {
  const ItemBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.sidePadding,
        left: SizeConfig.sidePadding,
        right: SizeConfig.sidePadding,
      ),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
            color: Colors.grey.shade300,
          ),
          padding: const EdgeInsets.all(12),
          child: SizedBox(width: width * 0.22, height: width * 0.18),
        ),
      ),
    );
  }
}
