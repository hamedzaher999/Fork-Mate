import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/controller/password_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:fork_mate/view/shared_widget/section_name_widget.dart';
import 'package:get/get.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title: 'Password'),
      body: GetX<PassWordController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(SizeConfig.sidePadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionNameWidget(
                    prefixIcon: Icons.lock_person_outlined,
                    sectionName: 'Change password',
                  ),
                  SizedBox(height: SizeConfig.sidePadding),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.sidePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!controller.forgetPassword.value)
                          CustomField(
                            title: 'old password',
                            controller: controller.oldPasswordController,
                            error: controller.oldPasswordError.value,
                            focusNode: controller.oldPasswordFocusNode,
                          ),
                        SizedBox(height: SizeConfig.sidePadding),
                        CustomField(
                          title: 'new password',
                          controller: controller.newPasswordController,
                          error: controller.newPasswordError.value,
                          focusNode: controller.newPasswordFocusNode,
                        ),
                        SizedBox(height: SizeConfig.sidePadding),
                        CustomField(
                          title: 'confirm password',
                          controller: controller.confirmPasswordController,
                          error: controller.confirmPasswordError.value,
                          focusNode: controller.confirmPasswordFocusNode,
                          response: controller.response.value,
                        ),
                        SizedBox(height: SizeConfig.sidePadding),
                        if (controller.forgetPassword.value)
                          CustomField(
                            title: 'code',
                            isNumber: true,
                            maxLength: 5,
                            controller: controller.codeController,
                            error: controller.codeError.value,
                            focusNode: controller.codeFocusNode,
                            response: controller.codeResponse.value,
                            suffix: GestureDetector(
                              onTap: () {
                                if (controller.forgetPassword.value) {
                                  controller.changePasswordWithCodeAndToken();
                                } else {
                                  controller.changeOldPassword();
                                }
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
                                  child: controller.isPasswordChanging.value
                                      ? MiniCircularIndicator()
                                      : Icon(Icons.check, color: black),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: SizeConfig.sidePaddingX2),
                        if (controller.forgetPassword.value)
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  controller.getVerificationCode(by: 'TOKEN');
                                },
                                child: Text(
                                  'resend code'.tr,
                                  style: TextStyle(
                                    color: controller.resendCodeAvailable.value
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeConfig.sidePadding),
                              if (!controller.resendCodeAvailable.value)
                                Text(
                                  "${'after'.tr}   ${controller.secondsRemaining.value.toString()}",
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontXSmall,
                                  ),
                                ),
                            ],
                          ),
                        SizedBox(height: SizeConfig.sidePadding),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
