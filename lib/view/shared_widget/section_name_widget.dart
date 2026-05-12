import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get_utils/get_utils.dart';

class SectionNameWidget extends StatelessWidget {
  const SectionNameWidget({
    super.key,
    required this.sectionName,
    this.prefixIcon,
    this.suffix,
    this.textSize,
  });
  final String sectionName;
  final IconData? prefixIcon;
  final Widget? suffix;
  final double? textSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.sidePadding,
                    ),
                    child: Icon(
                      prefixIcon,
                      color: elegantYellow,
                      size: SizeConfig.fontRegular,
                    ),
                  )
                : SizedBox(width: SizeConfig.sidePadding),
            Text(
              sectionName.tr,
              style: TextStyle(fontSize: textSize ?? SizeConfig.fontMedium),
            ),
          ],
        ),
        if (suffix != null) suffix!,
      ],
    );
  }
}
