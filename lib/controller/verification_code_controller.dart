import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/services/authentication_services.dart';
import 'package:fork_mate/services/customer/customer_data_services.dart';
import 'package:get/get.dart';

class VerificationCodeController extends GetxController {
  TextEditingController codeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  FocusNode numberFocusNode = FocusNode();
  FocusNode codeFocusNode = FocusNode();
  //--
  RxBool codeError = false.obs;
  RxBool numberError = false.obs;
  //-----
  Timer? _timer;
  RxInt secondsRemaining = 30.obs;
  RxBool resendCodeAvailable = true.obs;
  //--
  RxBool isCodeSent = false.obs;
  RxBool isCodeBeingSent = false.obs;
  //request counter
  int getCodeByTokenRequestCount = 0;
  int getCodeByNumberRequestCount = 0;
  int isNumberAvailableRequestCount = 0;
  //---responses
  Rxn<Map<String, dynamic>> codeResponse = Rxn(null);
  Rxn<Map<String, dynamic>> numberResponse = Rxn(null);

  void killTimer() {
    resendCodeAvailable.value = true;
    _timer?.cancel();
  }

  //done
  void isNumberAvailable({VoidCallback? onSuccess}) async {
    if (!checkNumberField()) return;
    numberFocusNode.unfocus();
    try {
      startTimer();
      numberResponse.value = null;
      isCodeBeingSent.value = true;
      numberResponse.value = await AuthenticationServices.isNumberAvailable(
        number: numberController.text,
      );
      if (numberResponse.value!['status'] == 'success') {
        isCodeSent.value = true;
        onSuccess?.call();
        return;
      }
    } catch (_) {
      isNumberAvailableRequestCount++;
      if (isNumberAvailableRequestCount <= 3) {
        isNumberAvailable(onSuccess: onSuccess);
      } else {
        isNumberAvailableRequestCount = 0;
        killTimer();
        createSnackBar(error: true);
        return;
      }
    } finally {
      if (isNumberAvailableRequestCount == 0) {
        isCodeBeingSent.value = false;
      }
    }
  }

  void getVerificationCode({required String by}) {
    if (!resendCodeAvailable.value) return;
    if (by == 'TOKEN') {
      getVerificationCodeByToken();
    } else {
      getVerificationCodeByNumber();
    }
  }

  void startTimer() {
    if (_timer?.isActive ?? false) return;
    secondsRemaining.value = 30;
    resendCodeAvailable.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        resendCodeAvailable.value = true;
        timer.cancel();
      }
    });
  }

  bool checkCodeField() {
    if (codeController.text.length < 5) {
      codeError.value = true;
      createSnackBar(message: 'the code must be at least 5 digits');
      return false;
    } else {
      codeError.value = false;
      codeFocusNode.unfocus();
      return true;
    }
  }

  bool checkNumberField() {
    if (numberController.text.trim().isEmpty) {
      numberError.value = true;
      return false;
    } else {
      numberError.value = false;
      return true;
    }
  }

  Future<void> getVerificationCodeByToken() async {
    startTimer();
    try {
      codeResponse.value = null;
      isCodeBeingSent.value = true;
      codeResponse.value =
          await CustomerDataServices.getVerificationCodeByToken();

      if (codeResponse.value!['status'] == 'success') {
        isCodeSent.value = true;
        return;
      }
    } catch (_) {
      getCodeByTokenRequestCount++;
      if (getCodeByTokenRequestCount <= 3) {
        await Future.delayed(Duration(seconds: 2));
        getVerificationCodeByToken();
      } else {
        getCodeByTokenRequestCount = 0;
        killTimer();
        createSnackBar(error: true);
        return;
      }
    } finally {
      if (getCodeByTokenRequestCount == 0) {
        isCodeBeingSent.value = false;
      }
    }
  }

  Future<void> getVerificationCodeByNumber() async {
    if (!checkNumberField()) return;
    startTimer();
    numberFocusNode.unfocus();
    try {
      codeResponse.value = null;
      isCodeBeingSent.value = true;
      codeResponse.value =
          await AuthenticationServices.getVerificationCodeByNumber(
            number: numberController.text,
          );

      if (codeResponse.value?['status'] == 'success') {
        isCodeSent.value = true;
        return;
      }
    } catch (_) {
      getCodeByNumberRequestCount++;
      if (getCodeByNumberRequestCount <= 3) {
        await Future.delayed(Duration(seconds: 2));
        getVerificationCodeByNumber();
      } else {
        getCodeByNumberRequestCount = 0;
        killTimer();
        createSnackBar(error: true);
        return;
      }
    } finally {
      if (getCodeByNumberRequestCount == 0) {
        isCodeBeingSent.value = false;
      }
    }
  }

  @override
  onClose() {
    numberController.dispose();
    codeController.dispose();
    numberFocusNode.dispose();
    codeFocusNode.dispose();
    super.onClose();
  }
}
