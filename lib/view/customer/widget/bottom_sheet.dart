import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.radius * 2),
          topRight: Radius.circular(SizeConfig.radius * 2),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.8, sigmaY: 1.5),
          child: Container(
            decoration: BoxDecoration(
              color: elegantYellow.withValues(alpha: .25),
            ),
            width: SizeConfig.width,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.sidePadding),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
