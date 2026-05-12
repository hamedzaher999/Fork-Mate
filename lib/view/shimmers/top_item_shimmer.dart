import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class TopItemShimmer extends StatelessWidget {
  const TopItemShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SizedBox(
        width: SizeConfig.width * 0.18,
        child: Column(
          children: [
            Container(
              width: SizeConfig.width * 0.18,
              height: SizeConfig.width * 0.18,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(SizeConfig.radius * 1.2),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.sidePadding / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Icon(MdiIcons.star, size: SizeConfig.fontMedium)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
