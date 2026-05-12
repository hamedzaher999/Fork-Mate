import 'package:flutter/material.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/controller/verification_code_controller.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/services/customer/customer_data_services.dart';
import 'package:get/state_manager.dart';

class PersonalInfoController extends VerificationCodeController {
  TextEditingController nameController = TextEditingController(
    text: AppServices.name,
  );
  TextEditingController userNameController = TextEditingController(
    text: AppServices.userName,
  );
  @override
  void onInit() {
    super.onInit();
    numberController.text = AppServices.phoneNumber ?? '';
  }

  //--
  FocusNode nameFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  //--
  RxBool nameFieldError = false.obs;
  RxBool usernameFieldError = false.obs;
  //--
  Rxn<Map<String, dynamic>> infoResponse = Rxn(null);
  //request counters
  int changeInfoRequestCount = 0;
  int changeNumberRequestCount = 0;
  //-----
  RxBool isInfoSectionOpen = false.obs;
  RxBool isNumberSectionOpen = false.obs;
  //-----
  RxBool isNumberChanging = false.obs;

  void openInfoSection() {
    isInfoSectionOpen.value = !isInfoSectionOpen.value;
    if (isInfoSectionOpen.value) {
      isNumberSectionOpen.value = false;
    }
  }

  void openNumberSection() {
    isNumberSectionOpen.value = !isNumberSectionOpen.value;
    if (isNumberSectionOpen.value) {
      isInfoSectionOpen.value = false;
    }
  }

  void changeInfo() async {
    if (!checkInfo()) return;
    nameFocusNode.unfocus();
    usernameFocusNode.unfocus();
    try {
      infoResponse.value = null;
      infoResponse.value = await CustomerDataServices.changePersonalInfo(
        name: nameController.text,
        userName: userNameController.text,
      );
      if (infoResponse.value!['status'] == 'success') {
        AppServices.setUserDetails(
          newName: infoResponse.value!['information']['name'],
          newUserName: infoResponse.value!['information']['userName'],
          newPhoneNumber: infoResponse.value!['information']['phoneNumber'],
        );
        // if (updateInfo) {
        //   isCodeSent.value = false;
        //   createSnackBar(
        //     message: infoResponse.value!['message'],
        //     milliSecondDuration: 2000,
        //   );
        //   return;
        // } else {
        //   createSnackBar(
        //     message: 'something went wrong please try again.',
        //     milliSecondDuration: 2000,
        //   );
        // }
      }
    } catch (_) {
      changeInfoRequestCount++;
      if (changeInfoRequestCount <= 3) {
        changeInfo();
      } else {
        changeInfoRequestCount = 0;
        createSnackBar(networkError: true);
        return;
      }
    }
  }

  void changeNumber() async {
    if (!checkCode()) return;
    try {
      codeFocusNode.unfocus();
      numberFocusNode.unfocus();
      isNumberChanging.value = true;
      numberResponse.value = await CustomerDataServices.changeNumber(
        number: numberController.text,
        code: codeController.text,
      );
      if (numberResponse.value!['status'] == 'success') {
        try {
          AppServices.setUserDetails(
            newName: numberResponse.value!['data']['name'],
            newUserName: numberResponse.value!['data']['userName'],
            newPhoneNumber: numberResponse.value!['data']['phoneNumber'],
          );
          isCodeSent.value = false;
          super.codeController.clear();
          super.codeError.value = false;
        } catch (_) {
          createSnackBar(error: true);
        }
      }
    } catch (_) {
      changeNumberRequestCount++;
      if (changeNumberRequestCount <= 3) {
        changeNumber();
      } else {
        changeNumberRequestCount = 0;
        createSnackBar(error: true);
        return;
      }
    } finally {
      if (changeNumberRequestCount == 0) {
        isNumberChanging.value = false;
      }
    }
  }

  bool checkNumber() {
    if (numberController.text.trim().isEmpty) {
      numberError.value = true;
      return false;
    } else {
      numberError.value = false;
    }
    if (numberController.text == AppServices.phoneNumber) {
      createSnackBar(message: 'please change the number first');
      return false;
    }
    return true;
  }

  bool checkCode() {
    if (codeController.text.trim().length < 5) {
      createSnackBar(message: 'the code must be at least 5 digits');
      codeError.value = true;
      return false;
    } else {
      codeError.value = false;
    }
    return true;
  }

  bool checkInfo() {
    if (nameController.text.trim().isEmpty) {
      nameFieldError.value = true;
      return false;
    } else {
      nameFieldError.value = false;
    }
    if (userNameController.text.trim().isEmpty) {
      usernameFieldError.value = true;
      return false;
    } else {
      usernameFieldError.value = false;
    }
    if (nameController.text == AppServices.name &&
        userNameController.text == AppServices.userName) {
      createSnackBar(message: 'please update your information first');
      return false;
    }
    return true;
  }

  @override
  void isNumberAvailable({VoidCallback? onSuccess}) {
    if (!checkNumber()) return;
    super.isNumberAvailable(onSuccess: onSuccess);
  }

  @override
  void onClose() {
    nameController.dispose();
    userNameController.dispose();
    //--
    nameFocusNode.dispose();
    usernameFocusNode.dispose();
    //------
    super.onClose();
  }
}
