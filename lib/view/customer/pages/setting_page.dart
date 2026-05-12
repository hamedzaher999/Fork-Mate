import 'package:flutter/material.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/controller/setting_controller.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/logout.dart';
import 'package:fork_mate/view/customer/widget/delete_account_box.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fork_mate/app/app.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/custom_app_bar.dart';
import 'package:fork_mate/view/customer/widget/setting_icon.dart';
import 'package:fork_mate/view/customer/widget/settings_icons_grid.dart';
import 'package:fork_mate/view/shared_widget/section_name_widget.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget: GestureDetector(
          onTap: () {
            controller.scrollController.animateTo(
              controller.scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
            );
          },
          child: Icon(MdiIcons.logout, color: Colors.red),
        ),
        displayIcons: false,
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.sidePadding),
          child: Column(
            children: [
              SectionNameWidget(
                sectionName: 'Personal Information',
                suffix: GestureDetector(
                  onTap: () {
                    Get.toNamed('/editPersonalInfoPage');
                  },
                  child: Icon(Icons.edit, color: elegantYellow),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed('/editPersonalInfoPage');
                },
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.sidePadding),
                  width: SizeConfig.width,
                  decoration: simpleBoxDecoration,
                  child: AbsorbPointer(
                    child: Column(
                      spacing: SizeConfig.sidePadding,
                      children: [
                        SettingIcon(
                          text: AppServices.name ?? '',
                          icon: MdiIcons.cardAccountDetails,
                        ),
                        SettingIcon(
                          text: AppServices.userName ?? '',
                          icon: MdiIcons.at,
                        ),
                        SettingIcon(
                          text: AppServices.phoneNumber ?? "",
                          icon: MdiIcons.phone,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //--------------------
              ...settings.entries.map(
                (setting) => SettingsIconsGrid(
                  setting: setting.value,
                  sectionName: setting.key.tr,
                ),
              ),
              SizedBox(height: SizeConfig.sidePadding),
              SectionNameWidget(sectionName: 'Account'),
              Container(
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                decoration: simpleBoxDecoration,
                child: Column(
                  spacing: SizeConfig.sidePadding,
                  children: [
                    SettingIcon(
                      text: 'Logout',
                      icon: MdiIcons.logout,
                      onTap: logout,
                    ),
                    SettingIcon(
                      text: 'Delete Account',
                      icon: MdiIcons.delete,
                      iconColor: Colors.red,
                      onTap: () {
                        confirmationDialog(
                          message:
                              "if you delete your account, you'll lose all your data and benefits",
                        ).then((confirm) {
                          if (!confirm) return;
                          Get.dialog(Dialog(child: DeleteAccountBox()));
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
