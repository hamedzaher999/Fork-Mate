import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get.dart';

class GradientTape extends StatelessWidget {
  const GradientTape({
    super.key,
    this.color,
    this.icon,
    this.text,
    this.textColor,
    this.tapeWidth,
  });
  final Color? color;
  final String? text;
  final Color? textColor;
  final IconData? icon;
  final double? tapeWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.sidePadding),
      child: Container(
        width: SizeConfig.width,
        height: tapeWidth ?? SizeConfig.height * 0.04,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color ?? elegantYellow,
              color?.withAlpha(0) ?? elegantYellow.withAlpha(0),
              // const Color.fromARGB(0, 255, 217, 0),
            ],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ),
        ),
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.sidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: SizeConfig.fontMedium, color: black),
                  SizedBox(width: SizeConfig.width * 0.02),
                  Text(
                    text?.tr ?? '',
                    style: TextStyle(
                      fontSize: SizeConfig.fontMedium,
                      height: 1,
                      color: color == null ? black : textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
