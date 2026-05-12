import 'package:flutter/cupertino.dart';
import 'package:fork_mate/app/app.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/setting_icon.dart';
import 'package:get/get.dart';

class LanguageBox extends StatelessWidget {
  const LanguageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: SizeConfig.height * 0.3),
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            SizedBox(height: SizeConfig.sidePadding),
        shrinkWrap: true,
        padding: EdgeInsets.all(SizeConfig.sidePadding),
        itemCount: language.entries.length,
        itemBuilder: (context, index) {
          return SettingIcon(
            selected:
                Locale(language.entries.toList()[index].key) == Get.locale,
            text: language.entries.toList()[index].value.tr,
            onTap: () async {
              await Get.updateLocale(
                Locale(language.entries.toList()[index].key),
              );
              await Get.forceAppUpdate();
              AppServices.saveLanguage(language.entries.toList()[index].key);
              Get.back();
            },
          );
        },
      ),
    );
  }
}
