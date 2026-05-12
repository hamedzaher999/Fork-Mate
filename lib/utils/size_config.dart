import 'package:flutter/material.dart';

class SizeConfig {
  static late double width;
  static late double height;
  static late double sidePadding;
  static late double sidePaddingX2;
  static late double radius;
  static late double horizontalSpace;
  static late double verticalSpace;
  static late double fontRegular;
  static late double fontXSmall;
  static late double fontXXSmall;
  static late double fontSmall;
  static late double fontMedium;
  static late double fontLarge;
  static late double fontXLarge;
  static void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    sidePadding = MediaQuery.of(context).size.width * 0.03;
    sidePaddingX2 = MediaQuery.of(context).size.width * 0.06;
    radius = MediaQuery.of(context).size.width * 0.05;
    fontXSmall = MediaQuery.of(context).size.width * 0.03;
    fontXXSmall = MediaQuery.of(context).size.width * 0.026;
    fontSmall = MediaQuery.of(context).size.width * 0.035;
    fontMedium = MediaQuery.of(context).size.width * 0.04;
    fontRegular = MediaQuery.of(context).size.width * 0.05;
    fontLarge = MediaQuery.of(context).size.width * 0.065;
    fontXLarge = MediaQuery.of(context).size.width * 0.08;
    horizontalSpace = MediaQuery.of(context).size.width * 0.01;
    verticalSpace = MediaQuery.of(context).size.width * 0.01;
  }
}
