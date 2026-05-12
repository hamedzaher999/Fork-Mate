import 'package:flutter/material.dart';
import 'package:fork_mate/controller/personal_info_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ChangeNameSection extends StatelessWidget {
  const ChangeNameSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<PersonalInfoController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(SizeConfig.sidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomField(
                title: 'name'.tr,
                controller: controller.nameController,
                error: controller.nameFieldError.value,
                focusNode: controller.nameFocusNode,
              ),
              SizedBox(height: SizeConfig.sidePadding),
              CustomField(
                title: 'user name'.tr,
                controller: controller.userNameController,
                error: controller.usernameFieldError.value,
                focusNode: controller.usernameFocusNode,
                response: controller.infoResponse.value,
              ),
              SizedBox(height: SizeConfig.sidePaddingX2),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomButton(
                  title: 'change'.tr,
                  isSelected: true,
                  onTap: () {
                    controller.changeInfo();
                  },
                ),
              ),
              SizedBox(height: SizeConfig.sidePadding),
            ],
          ),
        );
      },
    );
  }
}
