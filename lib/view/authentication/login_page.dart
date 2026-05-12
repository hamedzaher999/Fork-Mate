import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/login_controller.dart';
import 'package:fork_mate/view/sections/login_change_password_section.dart';
import 'package:fork_mate/view/sections/login_section.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            child: GetX<LoginController>(
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.sidePadding * 4,
                    left: SizeConfig.sidePadding * 4,
                    right: SizeConfig.sidePadding * 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.forgetPassword.value
                          ? LoginChangePasswordSection()
                          : LoginSection(),
                      SizedBox(height: SizeConfig.sidePadding * 3),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.setForgetPassword();
                              },
                              child: Text(
                                controller.forgetPassword.value
                                    ? 'use old password'.tr
                                    : 'forget password ?'.tr,

                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            SizedBox(height: SizeConfig.sidePadding),
                            if (controller.isCodeSent.value &&
                                controller.forgetPassword.value)
                              GestureDetector(
                                onTap: () {
                                  controller.getVerificationCode(by: "NUMBER");
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'resend code'.tr,
                                      style: TextStyle(
                                        color:
                                            controller.resendCodeAvailable.value
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: SizeConfig.sidePadding),
                                    if (!controller.resendCodeAvailable.value)
                                      Text(
                                        controller.secondsRemaining.value
                                            .toString(),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  Text("don't have an account ?".tr),
                  CustomButton(
                    title: 'signup',
                    isSelected: true,
                    onTap: () {
                      Get.offNamed('/signupPage');
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
