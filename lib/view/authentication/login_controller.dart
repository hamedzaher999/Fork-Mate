import 'package:flutter/material.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/controller/password_controller.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/services/authentication_services.dart';
import 'package:get/get.dart';

class LoginController extends PassWordController {
  //text field controller
  final numberOrUserNameController = TextEditingController();
  final numberOrUserNameFocusNode = FocusNode();
  RxBool numberOrUserNameError = false.obs;
  RxBool isLoggingIn = false.obs;
  // counters
  int loginRequestCount = 0;

  void login() async {
    super.response.value = null;
    if (!checkLoginRequirement()) return;
    try {
      isLoggingIn.value = true;
      numberOrUserNameFocusNode.unfocus();
      oldPasswordFocusNode.unfocus();
      Map<String, dynamic> response = await AuthenticationServices.login(
        usernameOrNumber: numberOrUserNameController.text,
        password: super.oldPasswordController.text,
      );
      if (response['status'] == 'success') {
        await AppServices.setUserDetails(
          newName: response['data']['name'],
          newUserName: response['data']['userName'],
          newPhoneNumber: response['data']['phoneNumber'],
        );
        await AppServices.setToken(response['data']['token']);
        Get.toNamed('/');
      } else {
        createSnackBar(message: response['message'], milliSecondDuration: 2000);
        return;
      }
    } catch (_) {
      loginRequestCount++;
      if (loginRequestCount <= 3) {
        await Future.delayed(Duration(seconds: 2));
        login();
      } else {
        loginRequestCount = 0;
        createSnackBar(error: true);
        return;
      }
    } finally {
      if (loginRequestCount == 0) {
        isLoggingIn.value = false;
      }
    }
  }

  bool checkLoginRequirement() {
    if (numberOrUserNameController.text.trim().isEmpty) {
      numberOrUserNameError.value = true;
      return false;
    } else {
      numberOrUserNameError.value = false;
    }
    if (!super.checkOldPasswordField()) {
      return false;
    }
    return true;
  }

  @override
  void setForgetPassword() {
    if (super.forgetPassword.value) {
      isCodeSent.value = false;
    }
    super.forgetPassword.value = !super.forgetPassword.value;
    clean();
  }

  @override
  void onClose() {
    numberOrUserNameController.dispose();
    numberOrUserNameFocusNode.dispose();
    super.onClose();
  }
}
