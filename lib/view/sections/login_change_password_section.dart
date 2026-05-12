import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/login_controller.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get.dart';

class LoginChangePasswordSection extends StatelessWidget {
  const LoginChangePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (controller) {
        return Column(
          children: [
            if (controller.forgetPassword.value && !controller.isCodeSent.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomField(
                    title: 'phone number',
                    controller: controller.numberController,
                    error: controller.numberError.value,
                    focusNode: controller.numberFocusNode,
                    isNumber: true,
                    suffix: GestureDetector(
                      onTap: () {
                        controller.getVerificationCode(by: "NUMBER");
                      },
                      child: Container(
                        height: SizeConfig.height * 0.045,
                        width: SizeConfig.height * 0.045,
                        decoration: BoxDecoration(
                          color: elegantYellow,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.radius / 1.3,
                          ),
                        ),
                        child: Center(
                          child: controller.isCodeBeingSent.value
                              ? MiniCircularIndicator()
                              : Icon(Icons.check, color: black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (controller.isCodeSent.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomField(
                    title: 'new password',
                    controller: controller.newPasswordController,
                    focusNode: controller.newPasswordFocusNode,
                    error: controller.newPasswordError.value,
                  ),
                  SizedBox(height: SizeConfig.sidePadding),
                  CustomField(
                    title: 'confirm password',
                    controller: controller.confirmPasswordController,
                    focusNode: controller.confirmPasswordFocusNode,
                    error: controller.confirmPasswordError.value,
                    response: controller.response.value,
                  ),
                  SizedBox(height: SizeConfig.sidePadding),
                  CustomField(
                    title: 'code',
                    controller: controller.codeController,
                    error: controller.codeError.value,
                    focusNode: controller.codeFocusNode,
                    response: controller.codeResponse.value,
                    isNumber: true,
                    maxLength: 5,
                    suffix: GestureDetector(
                      onTap: () {
                        if (!controller.isPasswordChanging.value) {
                          controller.changePasswordWithCodeAndNumber(
                            onChanged: () async {
                              Get.offAllNamed('/');
                            },
                          );
                        }
                      },
                      child: Container(
                        height: SizeConfig.height * 0.045,
                        width: SizeConfig.height * 0.045,
                        decoration: BoxDecoration(
                          color: elegantYellow,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.radius / 2,
                          ),
                        ),
                        child: Center(
                          child: controller.isPasswordChanging.value
                              ? MiniCircularIndicator()
                              : Icon(Icons.check, color: black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
