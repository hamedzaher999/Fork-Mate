import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/signup_controller.dart';
import 'package:fork_mate/view/sections/signup_code_section.dart';
import 'package:fork_mate/view/sections/signup_name_section.dart';
import 'package:fork_mate/view/sections/signup_number_section.dart';
import 'package:fork_mate/view/sections/signup_password_section.dart';
import 'package:fork_mate/view/sections/signup_username_section.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: GetBuilder<SignupController>(
              builder: (controller) {
                return PageView(
                  controller: controller.pageController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //name 0
                    SignupNameSection(),
                    //username 1
                    SignupUsernameSection(),
                    //password 2
                    SignupPasswordSection(),
                    //number 3
                    SignupNumberSection(),
                    //code 4
                    SignupCodeSection(),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(
                right: SizeConfig.sidePadding * 4,
                bottom: SizeConfig.sidePadding * 4,
                left: SizeConfig.sidePadding * 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('have an account'.tr),
                  CustomButton(
                    title: 'login',
                    isSelected: true,
                    onTap: () {
                      Get.offNamed('/loginPage');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
