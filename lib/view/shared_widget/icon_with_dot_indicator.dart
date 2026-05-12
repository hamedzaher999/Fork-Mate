import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class IconWithDotIndicator extends StatelessWidget {
  const IconWithDotIndicator({
    super.key,
    required this.icon,
    this.notification = false,
    this.onTap,
  });
  final IconData icon;
  final bool notification;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: elegantYellow, size: SizeConfig.fontRegular),
          if (notification)
            PositionedDirectional(
              top: -2,
              end: -2,
              child: Icon(
                Icons.circle,
                color: Colors.red,
                size: SizeConfig.fontXSmall / 2,
              ),
            ),
        ],
      ),
    );
  }
}
