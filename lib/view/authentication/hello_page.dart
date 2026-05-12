import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/language_box.dart';
import 'package:get/get.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello'.tr,
                      style: TextStyle(fontSize: SizeConfig.fontXLarge),
                    ),
                    Text(
                      'fork mate'.tr,
                      style: TextStyle(
                        fontSize: SizeConfig.fontXLarge,
                        color: elegantYellow,
                      ),
                    ),
                    SizedBox(height: SizeConfig.sidePadding * 3),

                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/loginPage');
                      },
                      child: Container(
                        height: SizeConfig.height * 0.05,
                        width: SizeConfig.width * 0.7,
                        decoration: BoxDecoration(
                          color: elegantYellow,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.radius,
                          ),
                          boxShadow: shadow,
                        ),
                        child: Center(
                          child: Text(
                            'login'.tr,

                            style: TextStyle(
                              color: black,

                              fontSize: SizeConfig.fontMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.sidePadding),

                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/signupPage');
                      },
                      child: Container(
                        height: SizeConfig.height * 0.05,
                        width: SizeConfig.width * 0.7,
                        decoration: BoxDecoration(
                          color: elegantYellow,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.radius,
                          ),
                          boxShadow: shadow,
                        ),
                        child: Center(
                          child: Text(
                            'signup'.tr,
                            style: TextStyle(
                              color: black,
                              fontSize: SizeConfig.fontMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            PositionedDirectional(
              start: SizeConfig.sidePadding,
              bottom: SizeConfig.sidePadding,
              child: GestureDetector(
                onTap: () {
                  Get.dialog(Dialog(child: LanguageBox()));
                },
                child: Icon(Icons.language, color: elegantYellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
