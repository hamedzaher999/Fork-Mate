import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/setting_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/pages/moth_archive_page.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/gradient_tape.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/shared_widget/waiting_indicator.dart';
import 'package:get/get.dart';

class ArchivePage extends GetView<SettingController> {
  const ArchivePage({super.key});
  @override
  Widget build(BuildContext context) {
    controller.fetchArchive();
    return Scaffold(
      appBar: BackAppBar(title: 'Archive'),
      body: GetX<SettingController>(
        builder: (controller) {
          if (controller.archive.value == null) {
            return controller.archiveFetchingError.value
                ? NetworkError()
                : WaitingIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ...controller.archive.value!.entries.map((years) {
                  return Column(
                    children: [
                      GradientTape(
                        text: years.key,
                        tapeWidth: SizeConfig.height * 0.04,
                      ),
                      ...(years.value as Map<String, dynamic>).entries.map((
                        month,
                      ) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => MothArchivePage(
                                month: month.key,
                                monthArchive: month.value,
                              ),
                            );
                          },
                          child: GradientTape(
                            text: month.key,

                            color: mainColor,
                          ),
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
