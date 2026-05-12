import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/controller/personal_info_controller.dart';
import 'package:fork_mate/view/sections/change_name_section.dart';
import 'package:fork_mate/view/sections/change_number_section.dart';
import 'package:fork_mate/view/shared_widget/section_name_widget.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditPersonalInfoPage extends StatelessWidget {
  const EditPersonalInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title: 'Personal Information'),
      body: GetX<PersonalInfoController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(SizeConfig.sidePadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.openInfoSection();
                    },
                    child: SectionNameWidget(
                      sectionName: 'Edit personal information',
                      prefixIcon: MdiIcons.cardAccountDetails,
                      textSize: SizeConfig.fontSmall,
                      suffix: Icon(
                        controller.isInfoSectionOpen.value
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down_sharp,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.sidePadding),
                  //change personal information section
                  if (controller.isInfoSectionOpen.value) ChangeNameSection(),
                  Divider(),
                  SizedBox(height: SizeConfig.sidePadding),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.openNumberSection();
                    },
                    child: SectionNameWidget(
                      sectionName: 'Change number',
                      prefixIcon: MdiIcons.phone,

                      textSize: SizeConfig.fontSmall,
                      suffix: Icon(
                        controller.isNumberSectionOpen.value
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down_sharp,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.sidePadding),
                  //change number section
                  if (controller.isNumberSectionOpen.value)
                    ChangeNumberSection(),
                  SizedBox(height: SizeConfig.height * 0.1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
