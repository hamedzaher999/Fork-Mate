import 'package:flutter/material.dart';
import 'package:fork_mate/app/app.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/show_delay_dialog.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/setting_icon.dart';
import 'package:fork_mate/view/floating_bottom_bar/floating_bottom_bar_controller.dart';
import 'package:get/get.dart';

class ThemeBox extends StatelessWidget {
  const ThemeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: SizeConfig.height * 0.3),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        itemCount: themes.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: SizeConfig.sidePadding),
        itemBuilder: (context, index) {
          return SettingIcon(
            selected:
                (themes[index] == 'light' && !Get.isDarkMode) ||
                (themes[index] == 'dark' && Get.isDarkMode),
            text: themes[index],
            icon: themes[index] == 'light' ? Icons.sunny : Icons.dark_mode,
            iconColor: themes[index] == 'light' ? elegantYellow : black,
            onTap: () async {
              Get.back();
              if (Get.isDarkMode && themes[index] == 'light') {
                Get.changeThemeMode(ThemeMode.light);
                AppServices.saveThemeMode('light');
                await showDelayDialog('applying theme'.tr, 2);
                Get.find<FloatingBottomBarController>().setPage(Pages.home);
              }
              if (!Get.isDarkMode && themes[index] == 'dark') {
                Get.changeThemeMode(ThemeMode.dark);
                AppServices.saveThemeMode('dark');

                await showDelayDialog('applying theme', 2);
                Get.find<FloatingBottomBarController>().setPage(Pages.home);
              }
            },
          );
        },
      ),
    );
  }
}
