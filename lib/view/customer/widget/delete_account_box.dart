import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/setting_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get.dart';

class DeleteAccountBox extends StatelessWidget {
  const DeleteAccountBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.sidePaddingX2,
        horizontal: SizeConfig.sidePadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.radius),
        border: Border.all(color: white),
        color: mainColor,
      ),

      child: GetX<SettingController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: SizeConfig.sidePadding,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomField(
                title: 'Password',
                controller: controller.passwordFiledController,
                focusNode: controller.passwordFocusNode,
                error: controller.passwordFieldError.value,
                response: controller.deleteAccountResponse.value,
              ),
              GestureDetector(
                onTap: controller.deleteAccount,
                child: Container(
                  decoration: BoxDecoration(
                    color: elegantYellow,
                    borderRadius: BorderRadius.circular(
                      SizeConfig.radius / 1.3,
                    ),
                  ),
                  height: SizeConfig.height * 0.045,
                  child: Center(
                    child: controller.isAccountBeingDeleted.value
                        ? MiniCircularIndicator()
                        : Text('delete'.tr, style: TextStyle(color: black)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.sidePadding,
                ),
                child: Text(
                  'you should enter the password to delete the account'.tr,
                  style: TextStyle(fontSize: SizeConfig.fontXXSmall),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed('/changePasswordPage');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.sidePadding,
                  ),
                  child: Text(
                    'forget password ?'.tr,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: SizeConfig.fontXSmall,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
