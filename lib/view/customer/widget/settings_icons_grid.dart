import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/shared_widget/section_name_widget.dart';

class SettingsIconsGrid extends StatelessWidget {
  const SettingsIconsGrid({
    super.key,
    required this.setting,
    this.crossAxisCount,
    this.sectionName,
    this.sectionPrefixIcon,
    this.sectionSuffixIcon,
  });
  final List<Map<String, dynamic>> setting;
  final int? crossAxisCount;
  final String? sectionName;
  final IconData? sectionPrefixIcon;
  final Widget? sectionSuffixIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.sidePaddingX2),

        if (sectionName != null)
          SectionNameWidget(
            sectionName: sectionName!,
            prefixIcon: sectionPrefixIcon,
            suffix: sectionSuffixIcon,
          ),

        GridView.count(
          crossAxisCount: crossAxisCount ?? 2,
          mainAxisSpacing: SizeConfig.horizontalSpace,
          crossAxisSpacing: SizeConfig.verticalSpace,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 2.8,
          children: [
            ...setting.map(
              (setting) => Padding(
                padding: const EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {
                    setting['onTap']?.call();
                  },
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.sidePadding),
                    height: SizeConfig.height * 0.01,
                    decoration: simpleBoxDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          setting['icon'],
                          color: elegantYellow,
                          size: SizeConfig.fontRegular,
                        ),
                        SizedBox(width: SizeConfig.horizontalSpace * 2),
                        Expanded(
                          flex: 1,
                          child: Text(
                            (setting['name'] as String).tr,
                            style: TextStyle(fontSize: SizeConfig.fontXSmall),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
