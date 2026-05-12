import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/customer_app.dart';

class FloatingBottomBarController extends GetxController {
  Pages page = Pages.home;
  List<Pages> pages = Pages.values;
  final pageController = PageController();
  void setPage(Pages newPage) async {
    page = newPage;
    int pageIndex = newPage.index;

    pageController.jumpToPage(pageIndex);
    update();
  }

  void onPageChanged(int index) {
    page = pages[index];

    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
