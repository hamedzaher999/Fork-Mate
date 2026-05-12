import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/signup_controller.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';

class SignupPasswordSection extends StatelessWidget {
  const SignupPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SignupController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.sidePadding * 4,
            left: SizeConfig.sidePadding * 4,
            right: SizeConfig.sidePadding * 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.swipeBack,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: elegantYellow,
                ),
              ),
              SizedBox(height: SizeConfig.sidePaddingX2),

              CustomField(
                title: 'new password'.tr,
                controller: controller.newPasswordController,
                error: controller.newPasswordError.value,
                focusNode: controller.newPasswordFocusNode,
              ),
              SizedBox(height: SizeConfig.sidePadding),
              CustomField(
                title: 'confirm password'.tr,
                controller: controller.confirmPasswordController,
                error: controller.confirmPasswordError.value,
                focusNode: controller.confirmPasswordFocusNode,
              ),
              SizedBox(height: SizeConfig.sidePadding * 3),
              GestureDetector(
                onTap: controller.comparePasswords,
                child: Container(
                  height: SizeConfig.height * 0.045,
                  decoration: BoxDecoration(
                    color: elegantYellow,
                    borderRadius: BorderRadius.circular(
                      SizeConfig.radius / 1.3,
                    ),
                  ),
                  child: Center(
                    child: controller.isRegistering.value
                        ? MiniCircularIndicator()
                        : Text('next'.tr, style: TextStyle(color: black)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
