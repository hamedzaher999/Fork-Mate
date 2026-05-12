import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get.dart';

class SettingIcon extends StatelessWidget {
  const SettingIcon({
    super.key,
    required this.text,
    this.icon,
    this.iconColor,
    this.onTap,
    this.selected = false,
  });
  final String text;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        decoration: BoxDecoration(
          border: selected ? Border.all(color: elegantYellow) : null,
          color: selected
              ? elegantYellow.withAlpha(30)
              : Get.isDarkMode
              ? Color.fromARGB(22, 158, 158, 158)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(SizeConfig.radius / 1.3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? elegantYellow,
                size: SizeConfig.fontRegular,
              ),
            SizedBox(width: SizeConfig.horizontalSpace * 2),
            Center(
              child: Text(
                text.tr,
                style: TextStyle(fontSize: SizeConfig.fontSmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
