import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/signup_controller.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/utils.dart';

class SignupNumberSection extends StatelessWidget {
  const SignupNumberSection({super.key});

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

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomField(
                    title: 'phone number'.tr,
                    controller: controller.numberController,
                    focusNode: controller.numberFocusNode,
                    error: controller.numberError.value,
                    response: controller.numberResponse.value,
                    isNumber: true,
                  ),
                  SizedBox(height: SizeConfig.sidePadding * 2),
                  GestureDetector(
                    onTap: () {
                      controller.isNumberAvailable(
                        onSuccess: () {
                          controller.swipe(4);
                        },
                      );
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
                        child: controller.isCodeBeingSent.value
                            ? MiniCircularIndicator()
                            : Text('ok'.tr, style: TextStyle(color: black)),
                      ),
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
