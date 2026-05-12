import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/personal_info_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

class ChangeNumberSection extends StatelessWidget {
  const ChangeNumberSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<PersonalInfoController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(SizeConfig.sidePadding),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CustomField(
                title: 'number',
                isNumber: true,
                controller: controller.numberController,
                error: controller.numberError.value,
                focusNode: controller.numberFocusNode,
                response: controller.numberResponse.value,
              ),
              SizedBox(height: SizeConfig.sidePaddingX2),

              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomButton(
                  title: controller.isCodeBeingSent.value
                      ? 'sending code...'
                      : 'change',
                  isSelected: true,
                  onTap: () {
                    if (!controller.isCodeBeingSent.value) {
                      controller.isNumberAvailable();
                    }
                  },
                ),
              ),
              SizedBox(height: SizeConfig.sidePadding / 2),
              if (controller.isCodeSent.value) ...[
                CustomField(
                  title: 'code',
                  width: SizeConfig.width * 0.5,
                  isNumber: true,
                  maxLength: 5,
                  controller: controller.codeController,
                  error: controller.codeError.value,
                  focusNode: controller.codeFocusNode,
                  response: controller.codeResponse.value,
                  suffix: GestureDetector(
                    onTap: () {
                      if (!controller.isNumberChanging.value) {
                        controller.changeNumber();
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
                        child: controller.isNumberChanging.value
                            ? MiniCircularIndicator()
                            : Icon(Icons.check, color: black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.sidePadding * 3),
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
                        Text(controller.secondsRemaining.value.toString()),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
