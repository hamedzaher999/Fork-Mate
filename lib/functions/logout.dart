import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/show_loading_dialog.dart';
import 'package:get/get.dart';

void logout({bool? confirm}) async {
  bool isConfirmed =
      confirm ??
      await confirmationDialog(
        message: 'do you want to logout ?',
        confirmText: 'Logout',

        showAlert: true,
      );
  if (isConfirmed) {
    showLoadingDialog();
    await AppServices.clear().then((success) {
      if (success) {
        Get.back();
        Get.offAllNamed('/');
      }
    });
  }
}
