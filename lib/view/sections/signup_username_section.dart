import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/signup_controller.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_utils/get_utils.dart';

class SignupUsernameSection extends StatelessWidget {
  const SignupUsernameSection({super.key});

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
                title: 'user name'.tr,
                controller: controller.usernameController,
                error: controller.usernameError.value,
                focusNode: controller.usernameFocusNode,
                response: controller.response.value,
              ),

              SizedBox(height: SizeConfig.sidePadding * 2),
              GestureDetector(
                onTap: () {
                  if (!controller.isUsernameBeingVerified.value) {
                    controller.isUsernameAvailable();
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
                    child: controller.isUsernameBeingVerified.value
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
