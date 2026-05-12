import 'package:flutter/cupertino.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/services/authentication_services.dart';
import 'package:fork_mate/view/authentication/login_controller.dart';
import 'package:get/get.dart';

class SignupController extends LoginController {
  PageController pageController = PageController();
  //text filed controller
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  RxBool firstNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool usernameError = false.obs;
  //request flags
  RxBool isRegistering = false.obs;
  RxBool isUsernameBeingVerified = false.obs;
  //counters
  int isUsernameAvailableRequestCount = 0;
  int signupRequestCount = 0;

  void swipeBack() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  //done
  Future<void> signup() async {
    if (!super.checkCodeField()) return;
    try {
      super.response.value = null;
      isRegistering.value = true;
      super.response.value = await AuthenticationServices.signup(
        number: super.numberController.text,
        code: super.codeController.text,
        password: super.newPasswordController.text,
        userName: usernameController.text,
      );

      if (response.value!['status'] == 'success') {
        await AppServices.setUserDetails(
          newName: response.value!['data']['name'],
          newUserName: response.value!['data']['userName'],
          newPhoneNumber: response.value!['data']['phoneNumber'],
        );
        await AppServices.setToken(response.value!['data']['token']);
        Get.offAllNamed('/');
      }
    } catch (_) {
      signupRequestCount++;
      if (signupRequestCount <= 3) {
        signup();
      } else {
        signupRequestCount = 0;
        createSnackBar(message: 'some thing went wrong pleas try again');
        return;
      }
    } finally {
      if (signupRequestCount == 0) {
        isRegistering.value = false;
      }
    }
  }

  bool checkSignupRequirement() {
    if (super.numberController.text.trim().isEmpty) {
      numberError.value = true;
      createSnackBar(message: 'you should fill number field ');
      return false;
    } else {
      numberError.value = false;
    }
    return true;
  }

  //done
  void isUsernameAvailable() async {
    if (!checkUsername()) return;
    try {
      isUsernameBeingVerified.value = true;
      super.response.value = null;
      super.response.value = await AuthenticationServices.isUsernameAvailable(
        username: usernameController.text,
      );
      if (response.value!['status'] == 'success') {
        swipe(2);
      }
    } catch (_) {
      isUsernameAvailableRequestCount++;
      if (isUsernameAvailableRequestCount <= 3) {
        isUsernameAvailable();
      } else {
        isUsernameAvailableRequestCount = 0;
        createSnackBar(
          message: 'something went wrong',
          milliSecondDuration: 2000,
        );
        return;
      }
    } finally {
      if (isUsernameAvailableRequestCount == 0) {
        isUsernameBeingVerified.value = false;
      }
    }
  }

  //done
  bool checkUsername() {
    if (usernameController.text.trim().isEmpty ||
        usernameController.text.trim().length < 3) {
      usernameError.value = true;
      return false;
    } else {
      usernameError.value = false;
    }
    usernameFocusNode.unfocus();
    return true;
  }
  //done

  void checkName() {
    if (firstNameController.text.trim().isEmpty ||
        firstNameController.text.trim().length < 3) {
      firstNameError.value = true;
      return;
    } else {
      firstNameError.value = false;
    }
    if (lastNameController.text.trim().isEmpty ||
        lastNameController.text.trim().length < 3) {
      lastNameError.value = true;
      return;
    } else {
      lastNameError.value = false;
    }
    firstNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    swipe(1);
  }
  //done

  void swipe(int page) {
    super.response.value = null;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  bool comparePasswords() {
    if (super.comparePasswords()) {
      swipe(3);
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    pageController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    //--
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    usernameFocusNode.dispose();
    super.onClose();
  }
}
