import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/signup_controller.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:get/get.dart';

class SignupNameSection extends StatelessWidget {
  const SignupNameSection({super.key});

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
              if (1 == 2)
                Row(
                  children: [
                    Row(
                      spacing: SizeConfig.sidePadding,
                      children: [
                        Container(
                          padding: EdgeInsets.all(SizeConfig.sidePadding),
                          decoration: BoxDecoration(
                            color: mainColor,

                            borderRadius: BorderRadius.circular(
                              SizeConfig.radius / 1.8,
                            ),
                          ),
                          child: Icon(Icons.person),
                        ),
                        Container(
                          padding: EdgeInsets.all(SizeConfig.sidePadding),
                          decoration: BoxDecoration(
                            color: mainColor,

                            borderRadius: BorderRadius.circular(
                              SizeConfig.radius / 1.8,
                            ),
                          ),
                          child: Icon(Icons.directions_bike_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: SizeConfig.sidePadding),

              CustomField(
                title: 'first name'.tr,
                controller: controller.firstNameController,
                error: controller.firstNameError.value,
                focusNode: controller.firstNameFocusNode,
              ),
              SizedBox(height: SizeConfig.sidePadding),
              CustomField(
                title: 'last name'.tr,
                controller: controller.lastNameController,
                error: controller.lastNameError.value,
                focusNode: controller.lastNameFocusNode,
              ),
              SizedBox(height: SizeConfig.sidePadding * 2),
              GestureDetector(
                onTap: controller.checkName,
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
                        ? SizedBox(
                            height: SizeConfig.height * 0.02,
                            width: SizeConfig.height * 0.02,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: black,
                            ),
                          )
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
