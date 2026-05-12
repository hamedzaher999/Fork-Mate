import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.isSelected = false,
    this.onTap,
    this.hasShadow = true,
    this.notification = false,
    this.icon,
    this.fontSize,
    this.color,
  });
  final String? title;

  final bool isSelected;
  final VoidCallback? onTap;
  final bool hasShadow;
  final IconData? icon;
  final double? fontSize;
  final Color? color;
  final bool notification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onTap != null ? onTap!() : null},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: fontSize == SizeConfig.fontRegular
                  ? SizeConfig.sidePaddingX2
                  : SizeConfig.sidePadding,
            ),
            decoration: BoxDecoration(
              color: color ?? (isSelected ? elegantYellow : mainColor),
              borderRadius: BorderRadius.circular(
                SizeConfig.width * 0.08 * 0.35,
              ),
              boxShadow: hasShadow ? shadow : [],
            ),
            constraints: BoxConstraints(minHeight: SizeConfig.width * 0.065),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    title?.tr ?? '',
                    textAlign: TextAlign.center,
                    textHeightBehavior: TextHeightBehavior(
                      applyHeightToLastDescent: true,
                    ),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: fontSize ?? SizeConfig.fontXSmall,
                      color: isSelected ? black : xMainColor,
                    ),
                  ),
                ),
                if (icon != null) Center(child: Icon(icon, color: mainColor)),
              ],
            ),
          ),
          if (notification)
            PositionedDirectional(
              top: -2,
              end: -2,
              child: Icon(
                Icons.circle,
                color: Colors.red,
                size: SizeConfig.fontXSmall / 1.5,
              ),
            ),
        ],
      ),
    );
  }
}
