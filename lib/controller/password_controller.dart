import 'package:flutter/material.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/controller/verification_code_controller.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/validate_password.dart';
import 'package:fork_mate/services/authentication_services.dart';
import 'package:fork_mate/services/customer/customer_data_services.dart';
import 'package:get/get.dart';

class PassWordController extends VerificationCodeController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //---
  final oldPasswordFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  //password fields flags
  RxBool oldPasswordError = false.obs;
  RxBool newPasswordError = false.obs;
  RxBool confirmPasswordError = false.obs;
  //sections controller
  RxBool forgetPassword = false.obs;
  //request flags
  RxBool isVerificationSucceeded = false.obs;
  RxBool isPasswordChanging = false.obs;
  Rxn<Map<String, dynamic>> response = Rxn(null);
  //counters
  int changePasswordREquestCount = 0;

  void changePasswordWithCodeAndToken({VoidCallback? onChanged}) async {
    if (!checkChangePasswordRequirement('FORGOTTEN_PASSWORD')) return;
    newPasswordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
    super.codeFocusNode.unfocus();
    codeResponse.value = null;
    isPasswordChanging.value = true;
    try {
      codeResponse.value = null;
      isPasswordChanging.value = true;
      codeResponse.value =
          await CustomerDataServices.changePasswordWithCodeAndToken(
            code: codeController.text,
            newPassword: newPasswordController.text,
          );

      if (codeResponse.value!['status'] == 'success') {
        clean();
        onChanged?.call();
        return;
      }
    } catch (_) {
      changePasswordREquestCount++;
      if (changePasswordREquestCount <= 3) {
        changePasswordWithCodeAndToken(onChanged: onChanged);
      } else {
        changePasswordREquestCount = 0;
        createSnackBar(error: true);
        return;
      }
    } finally {
      if (changePasswordREquestCount == 0) {
        isPasswordChanging.value = false;
      }
    }
  }

  void changePasswordWithCodeAndNumber({VoidCallback? onChanged}) async {
    if (!checkChangePasswordRequirement('FORGOTTEN_PASSWORD')) return;
    newPasswordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
    super.codeFocusNode.unfocus();
    try {
      response.value = null;
      isPasswordChanging.value = true;
      response.value =
          await AuthenticationServices.changePasswordWithCodeAndNumber(
            number: numberController.text,
            code: codeController.text,
            newPassword: newPasswordController.text,
          );

      if (response.value!['status'] == 'success') {
        onChanged?.call();
        return;
      }
    } catch (_) {
      changePasswordREquestCount++;
      if (changePasswordREquestCount <= 3) {
        changePasswordWithCodeAndToken(onChanged: onChanged);
      } else {
        changePasswordREquestCount = 0;
        createSnackBar(error: true);
        return;
      }
    } finally {
      if (changePasswordREquestCount == 0) {
        isPasswordChanging.value = false;
      }
    }
  }

  void changeOldPassword() async {
    if (!checkChangePasswordRequirement('OLD_PASSWORD')) return;
    response.value = null;
    if (!isPasswordChanging.value) {
      isPasswordChanging.value = true;
      try {
        response.value =
            await AuthenticationServices.changePasswordWithOldPassword(
              oldPassword: oldPasswordController.text,
              newPassword: newPasswordController.text,
            );
        if (response.value!['status'] == 'error') {
          return;
        } else {
          createSnackBar(
            message: response.value!['message'],
            textColor: Colors.green,
            milliSecondDuration: 2000,
          );
          clearTextController();
        }
      } catch (e) {
        createSnackBar(error: true);
        return;
      } finally {
        isPasswordChanging.value = false;
      }
    }
  }

  bool checkChangePasswordRequirement(String type) {
    if (type == 'OLD_PASSWORD') {
      if (!checkOldPasswordField()) {
        return false;
      }
    }
    if (type == 'FORGOTTEN_PASSWORD') {
      if (!super.checkCodeField()) {
        return false;
      }
    }
    if (!comparePasswords()) {
      return false;
    }
    return true;
  }

  bool checkOldPasswordField() {
    if (oldPasswordController.text.trim().isNotEmpty) {
      oldPasswordError.value = false;
    } else {
      oldPasswordError.value = true;
      return false;
    }
    return true;
  }

  bool comparePasswords() {
    if (newPasswordController.text.trim().isNotEmpty) {
      newPasswordError.value = false;
    } else {
      newPasswordError.value = true;
      return false;
    }
    if (!validatePassword(newPasswordController.text)) {
      newPasswordError.value = true;
      return false;
    }
    if (confirmPasswordController.text.trim().isNotEmpty) {
      confirmPasswordError.value = false;
    } else {
      confirmPasswordError.value = true;
      return false;
    }

    bool equal = newPasswordController.text == confirmPasswordController.text;
    if (!equal) {
      newPasswordError.value = true;
      confirmPasswordError.value = true;
      createSnackBar(
        message: 'passwords do not match',
        milliSecondDuration: 2000,
      );
    } else {
      newPasswordFocusNode.unfocus();
      confirmPasswordFocusNode.unfocus();
    }
    return equal;
  }

  void setForgetPassword() async {
    if (forgetPassword.value) {
      forgetPassword.value = false;
      response.value = null;
      return;
    }
    bool confirm = await confirmationDialog(
      message: 'we will send a verification code to this number @phone'
          .trParams({'phone': AppServices.phoneNumber.toString()}),
      confirmText: 'send',
    );

    if (confirm) {
      forgetPassword.value = true;
      getVerificationCode(by: "TOKEN");
      clearTextController();
      response.value = null;
    }
  }

  void clearTextController() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    //---
    oldPasswordFocusNode.unfocus();
    newPasswordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
    //--
    oldPasswordError.value = false;
    newPasswordError.value = false;
    confirmPasswordError.value = false;
  }

  void clean() {
    killTimer();
    clearTextController();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    //--
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    //--
    super.onClose();
  }
}
