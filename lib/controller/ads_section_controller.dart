import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/models/customer/advertisement_model.dart';
import 'package:fork_mate/services/customer/customer_home_page_services.dart';
import 'package:get/get.dart';

class AdsControllerController extends GetxController {
  PageController pageController = PageController(viewportFraction: 0.8);
  bool end = false;
  var currentPage = 0.0.obs;
  Timer? autoScrollTimer;
  int pageCount = 0;
  //--
  int advertisementsRequestCount = 0;
  Rx<List<AdvertisementModel>> advertisements = Rx<List<AdvertisementModel>>(
    localAdvertisementImages,
  );
  @override
  void onInit() {
    fetchAds();
    pageController.addListener(() {
      currentPage.value = pageController.page ?? 0.0;
    });
    super.onInit();
  }

  Future<void> fetchAds() async {
    try {
      final ads = await CustomerHomePageServices.fetchAdvertisements();
      advertisements.value = [...ads, ...localAdvertisementImages];
    } catch (e) {
      if (advertisementsRequestCount < 4) {
        advertisementsRequestCount++;
        await Future.delayed(Duration(seconds: 3));
        fetchAds();
      } else {
        advertisementsRequestCount = 0;
        return;
      }
    }
  }

  void startAutoScroll(int itemCount) {
    autoScrollTimer?.cancel();
    if (end) return;

    if (itemCount <= 1) return;

    autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!pageController.hasClients) return;

      int nextPage = (pageController.page?.round() ?? 0) + 1;

      if (nextPage < itemCount) {
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.ease,
        );
      } else {
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.ease,
        );
        end = true;
        autoScrollTimer?.cancel();
      }
    });
  }

  @override
  void onClose() {
    autoScrollTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
