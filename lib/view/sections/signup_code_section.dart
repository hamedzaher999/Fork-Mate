import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/signup_controller.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SignupCodeSection extends StatelessWidget {
  const SignupCodeSection({super.key});

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
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomField(
                    title: 'code'.tr,
                    controller: controller.codeController,
                    error: controller.codeError.value,
                    focusNode: controller.codeFocusNode,
                    response: controller.codeResponse.value,
                    isNumber: true,
                    maxLength: 5,
                  ),
                  SizedBox(height: SizeConfig.sidePadding * 2),
                  GestureDetector(
                    onTap: () {
                      if (!controller.isRegistering.value) {
                        controller.signup();
                      }
                    },
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
                            : Text('verify'.tr, style: TextStyle(color: black)),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.sidePadding * 3),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.getVerificationCode(by: "NUMBER");
                          },
                          child: Row(
                            children: [
                              Text(
                                'resend code'.tr,
                                style: TextStyle(
                                  color: controller.resendCodeAvailable.value
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                              SizedBox(width: SizeConfig.sidePadding),
                              if (!controller.resendCodeAvailable.value)
                                Text(
                                  controller.secondsRemaining.value.toString(),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.sidePadding),
                        GestureDetector(
                          onTap: controller.swipeBack,
                          child: Text(
                            'change phone number'.tr,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
