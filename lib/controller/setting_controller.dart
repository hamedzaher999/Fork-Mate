import 'package:flutter/material.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/logout.dart';
import 'package:fork_mate/services/authentication_services.dart';
import 'package:get/get.dart';
import 'package:fork_mate/services/customer/customer_data_services.dart';

class SettingController extends GetxController {
  //delete account controllers
  final ScrollController scrollController = ScrollController();
  final TextEditingController passwordFiledController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  Rxn<Map<String, dynamic>> deleteAccountResponse = Rxn(null);
  RxBool passwordFieldError = false.obs;
  RxBool isAccountBeingDeleted = false.obs;
  //archive page controllers
  RxBool isArchiveFetching = false.obs;
  RxBool archiveFetchingError = false.obs;
  Rxn<Map<String, dynamic>> archive = Rxn(null);
  //--

  Future<void> fetchArchive() async {
    archiveFetchingError.value = false;
    if (!isArchiveFetching.value) {
      isArchiveFetching.value = true;
      try {
        archive.value = await CustomerDataServices.archive();
      } catch (e) {
        archiveFetchingError.value = true;
      } finally {
        isArchiveFetching.value = false;
      }
    }
  }

  Future<void> deleteAccount() async {
    if (isAccountBeingDeleted.value) return;
    if (!checkPasswordField()) return;
    passwordFocusNode.unfocus();
    try {
      isAccountBeingDeleted.value = true;
      deleteAccountResponse.value = await AuthenticationServices.deleteAccount(
        password: passwordFiledController.text,
      );
      if (deleteAccountResponse.value!['status'] == 'success') {
        logout(confirm: true);
      }
    } catch (_) {
      createSnackBar(networkError: true);
    } finally {
      isAccountBeingDeleted.value = false;
    }
  }

  bool checkPasswordField() {
    if (passwordFiledController.text.trim().isEmpty) {
      passwordFieldError.value = true;
      return false;
    } else {
      passwordFieldError.value = false;
      return true;
    }
  }

  @override
  void onClose() {
    passwordFiledController.dispose();
    passwordFocusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
