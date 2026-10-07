import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/utils/size_config.dart';

//constant----------
// const Color elegantYellow = Color(0xFFFF8E3A); // orang e
const Color elegantYellow = Color(0xFFFFD700); // yellow
// const Color elegantYellow = Color(0xFF3A86FF); // blue
const Color stars = Color(0xFFFFD700); // yellow

const Color black = Color.fromARGB(204, 0, 0, 0);
const Color white = Color.fromARGB(204, 255, 255, 255);
const Color imagePlaceHolderColor = Color.fromARGB(255, 198, 196, 196);
const baseURL =
    'https://fork-mate-mock.onrender.com/api/hamed'; //get-----------------------------
Color get mainColor => Get.isDarkMode ? const Color(0xAA000000) : Colors.white;
Color get backGroundColor => Get.isDarkMode ? Color(0xFF303030) : Colors.white;
Color get xMainColor => Get.isDarkMode ? Colors.white : Colors.black;
Color get baseColor =>
    Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
Color get highlightColor =>
    Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;
List<BoxShadow> get shadow => !Get.isDarkMode
    ? [
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 0.1,
          color: Color.fromARGB(207, 158, 158, 158),
        ),
      ]
    : [];
BoxDecoration get boxDecoration => BoxDecoration(
  color: mainColor,
  boxShadow: shadow,
  borderRadius: BorderRadius.circular(SizeConfig.radius * 1.2),
);
BoxDecoration get simpleBoxDecoration => BoxDecoration(
  color: mainColor,
  borderRadius: BorderRadius.circular(SizeConfig.radius * 1.2),
);
