import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Counter extends StatelessWidget {
  const Counter({
    super.key,
    required this.count,
    required this.increment,
    required this.decrement,
    this.size,
  });
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                increment();
              },
              child: Container(
                width: size ?? SizeConfig.width * 0.05,
                height: size ?? SizeConfig.width * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.radius * 0.3),
                  color: elegantYellow,
                ),
                child: Icon(
                  MdiIcons.plus,
                  size: SizeConfig.fontSmall,
                  color: black,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.width * 0.02),
            Text(
              count.toString(),
              style: TextStyle(fontSize: SizeConfig.fontMedium),
            ),
            SizedBox(width: SizeConfig.width * 0.02),

            GestureDetector(
              onTap: () {
                decrement();
              },
              child: Container(
                width: size ?? SizeConfig.width * 0.05,
                height: size ?? SizeConfig.width * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.radius * 0.3),
                  color: elegantYellow,
                ),
                child: Icon(
                  MdiIcons.minus,
                  size: SizeConfig.fontSmall,
                  color: black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
