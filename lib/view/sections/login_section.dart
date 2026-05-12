import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/login_controller.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomField(
              title: 'username or phone number',
              focusNode: controller.numberOrUserNameFocusNode,
              controller: controller.numberOrUserNameController,
              error: controller.numberOrUserNameError.value,
            ),
            SizedBox(height: SizeConfig.sidePadding),
            CustomField(
              title: 'Password',
              controller: controller.oldPasswordController,
              focusNode: controller.oldPasswordFocusNode,
              error: controller.oldPasswordError.value,
            ),
            SizedBox(height: SizeConfig.sidePadding * 2),
            GestureDetector(
              onTap: () {
                if (!controller.isLoggingIn.value) {
                  controller.login();
                }
              },
              child: Container(
                height: SizeConfig.height * 0.045,
                decoration: BoxDecoration(
                  color: elegantYellow,
                  borderRadius: BorderRadius.circular(SizeConfig.radius / 1.3),
                ),
                child: Center(
                  child: controller.isLoggingIn.value
                      ? MiniCircularIndicator()
                      : Text('login'.tr, style: TextStyle(color: black)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
