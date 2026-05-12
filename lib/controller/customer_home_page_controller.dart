import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/functions/show_delay_dialog.dart';
import 'package:get/get.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/models/customer/offer_model.dart';
import 'package:fork_mate/services/customer/customer_home_page_services.dart';

class CustomerHomePageController extends GetxController {
  //network error flags
  RxBool storeStatusNetworkError = false.obs;
  RxBool topItemsNetworkError = false.obs;
  RxBool newItemsNetworkError = false.obs;
  RxBool offersNetworkError = false.obs;
  RxBool discountNetworkError = false.obs;
  //fetching flags
  RxBool isStoreStatusFetching = false.obs;
  RxBool isTopItemFetching = false.obs;
  RxBool isNewItemFetching = false.obs;
  RxBool isOffersFetching = false.obs;
  RxBool isDiscountFetching = false.obs;
  //scroll controller
  ScrollController verticalController = ScrollController();
  ScrollController discountListController = ScrollController();
  ScrollController topItemsListController = ScrollController();
  ScrollController offerListController = ScrollController();
  //-----
  RxnBool storeStatus = RxnBool(null);
  Rx<List<ItemModel>?> topItems = Rx<List<ItemModel>?>(null);
  Rx<List<ItemModel>?> discounts = Rx<List<ItemModel>?>(null);
  Rx<List<ItemModel>?> newItems = Rx<List<ItemModel>?>(null);
  Rx<List<OfferModel>?> offers = Rx<List<OfferModel>?>(null);

  @override
  void onInit() async {
    //--------
    onEnter();
    verticalController.addListener(() {
      isEndOfVerticalList();
    });
    discountListController.addListener(() {
      isEndOfDiscountsItemList();
    });
    topItemsListController.addListener(() {
      isEndOfTopItemsList();
    });
    offerListController.addListener(() {
      isEndOfOfferList();
    });
    super.onInit();
  }

  Future<void> onEnter() async {
    getStoreStatus();
    fetchOffer();
    fetchTopItems();
    fetchNewItem();
    fetchDiscounts();
  }

  Future<void> getStoreStatus() async {
    storeStatusNetworkError.value = false;
    if (!isStoreStatusFetching.value) {
      isStoreStatusFetching.value = true;
      try {
        bool status = await CustomerHomePageServices.storeStatus();
        storeStatus.value = status;
      } catch (e) {
        storeStatusNetworkError.value = true;
      } finally {
        isStoreStatusFetching.value = false;
      }
    }
  }

  Future<void> fetchOffer() async {
    offersNetworkError.value = false;
    if (!isOffersFetching.value) {
      try {
        isOffersFetching.value = true;
        List<OfferModel> activator =
            await CustomerHomePageServices.fetchOffers();
        for (var element in activator) {
          final timer = CountdownController(
            timeString: element.remainingTime,
            tag: element.tag,
          );
          timer.callBackMap[element.tag] = () {
            offers.value?.remove(element);
            final controller = Get.find<CartController>();
            for (int i in controller.cart.keys) {
              controller.cart[i]!.removeOffer(
                int.parse(timer.tag.split('#')[1]),
              );
            }
            controller.fixCart();
            offers.refresh();
            //
          };
          Get.put(timer, tag: timer.tag);
        }
        offers.value = activator;
      } catch (e) {
        offersNetworkError.value = true;
      } finally {
        isOffersFetching.value = false;
      }
    }
  }

  Future<void> fetchDiscounts() async {
    discountNetworkError.value = false;
    if (!isDiscountFetching.value) {
      try {
        isDiscountFetching.value = true;
        List<ItemModel> activator =
            await CustomerHomePageServices.fetchDiscounts();
        for (var element in activator) {
          element.callBackKey = 'discount_${element.tag}';
          void onEnd() {
            discounts.value?.remove(element);
            Get.find<CartController>().removeDiscountFromItem(element.id);
            discounts.refresh();
          }

          //#case 1
          if (Get.isRegistered<CountdownController>(tag: element.tag)) {
            final timer = Get.find<CountdownController>(tag: element.tag);
            timer.callBackMap[element.callBackKey] = onEnd;
            continue;
          }
          //case 2
          CountdownController timer = CountdownController(
            timeString: element.discount!.leftTime,
            tag: element.tag,
          );
          timer.callBackMap[element.callBackKey] = onEnd;
          Get.put(timer, tag: element.tag);
        }
        discounts.value = activator;
      } catch (e) {
        discountNetworkError.value = true;
      } finally {
        isDiscountFetching.value = false;
      }
    }
  }

  Future<void> fetchTopItems() async {
    topItemsNetworkError.value = false;
    if (!isTopItemFetching.value) {
      isTopItemFetching.value = true;
      try {
        List<ItemModel> activator =
            await CustomerHomePageServices.fetchTopItems();
        for (var element in activator) {
          if (element.discount == null) continue;
          element.callBackKey = 'Top_${element.tag}';
          void onEnd() {
            element.discount = null;
            // Handle the case where an item’s discount expires while it’s still in the cart
            Get.find<CartController>().removeDiscountFromItem(element.id);
            topItems.refresh();
          }

          //#case 1
          if (Get.isRegistered<CountdownController>(tag: element.tag)) {
            final timer = Get.find<CountdownController>(tag: element.tag);
            // timer.remainingTime(element.discount!.leftTime);
            timer.callBackMap[element.callBackKey] = onEnd;
            continue;
          }
          CountdownController timer = CountdownController(
            timeString: element.discount!.leftTime,
            tag: element.tag,
          );
          timer.callBackMap[element.callBackKey] = onEnd;
          Get.put(timer, tag: element.tag);
        }
        topItems.value = activator;
      } catch (_) {
        topItemsNetworkError.value = true;
      } finally {
        isTopItemFetching.value = false;
      }
    }
  }

  Future<void> fetchNewItem() async {
    newItemsNetworkError.value = false;

    if (!isNewItemFetching.value) {
      isNewItemFetching.value = true;
      try {
        List<ItemModel> activator =
            await CustomerHomePageServices.fetchNewItems();
        for (var element in activator) {
          if (element.discount == null) continue;
          element.callBackKey = 'new_${element.tag}';
          void onEnd() {
            element.discount = null;
            // Handle the case where an item’s discount expires while it’s still in the cart
            Get.find<CartController>().removeDiscountFromItem(element.id);
            newItems.refresh();
          }

          //#case 1
          if (Get.isRegistered<CountdownController>(tag: element.tag)) {
            final timer = Get.find<CountdownController>(tag: element.tag);
            timer.callBackMap[element.callBackKey] = onEnd;
            continue;
          }
          CountdownController timer = CountdownController(
            timeString: element.discount!.leftTime,
            tag: element.tag,
          );
          timer.callBackMap[element.callBackKey] = onEnd;
          Get.put(timer, tag: timer.tag);
        }
        newItems.value = activator;
      } catch (e) {
        newItemsNetworkError.value = true;
      } finally {
        isNewItemFetching.value = false;
      }
    }
  }

  Future<void> refreshPage() async {
    await Future.delayed(const Duration(seconds: 1));
    //error flags
    storeStatusNetworkError.value = false;
    topItemsNetworkError.value = false;
    newItemsNetworkError.value = false;
    offersNetworkError.value = false;
    discountNetworkError.value = false;
    //fetching flags
    isStoreStatusFetching.value = false;
    isTopItemFetching.value = false;
    isNewItemFetching.value = false;
    isOffersFetching.value = false;
    isDiscountFetching.value = false;
    //data
    // await countDownControllerDisposer();
    await offerCounterDisposer();
    discounts.value = null;
    storeStatus.value = null;
    topItems.value = null;
    newItems.value = null;
    offers.value = null;
    onEnter();
  }

  Future offerCounterDisposer() async {
    if (offers.value != null) {
      for (var e in offers.value!) {
        await Get.delete<CountdownController>(tag: e.tag, force: true);
      }
    }
  } //

  Future discountCounterDisposer() async {
    if (discounts.value != null) {
      for (var e in discounts.value!) {
        if (Get.isRegistered<CountdownController>(tag: e.tag)) {
          Get.find<CountdownController>(
            tag: e.tag,
          ).callBackMap.remove(e.callBackKey);
        }
        // await Get.delete<CountdownController>(tag: e.tag, force: true);
      }
    }
  }

  //
  Future topItemCounterDisposer() async {
    if (topItems.value != null) {
      for (var e in topItems.value!) {
        if (e.discount == null) continue;
        if (Get.isRegistered<CountdownController>(tag: e.tag)) {
          Get.find<CountdownController>(
            tag: e.tag,
          ).callBackMap.remove(e.callBackKey);
        }
        // await Get.delete<CountdownController>(tag: e.tag, force: true);
      }
    }
  }

  Future newItemCounterDisposer() async {
    if (newItems.value != null) {
      for (var e in newItems.value!) {
        if (e.discount == null) continue;
        if (Get.isRegistered<CountdownController>(tag: e.tag)) {
          Get.find<CountdownController>(
            tag: e.tag,
          ).callBackMap.remove(e.callBackKey);
        }
        // await Get.delete<CountdownController>(tag: e.tag, force: true);
      }
    }
  }
  //

  Future countDownControllerDisposer() async {
    await offerCounterDisposer();
    await discountCounterDisposer();
    await topItemCounterDisposer();
    await newItemCounterDisposer();
  }

  Future<void> refreshOffers() async {
    offersNetworkError.value = false;
    await offerCounterDisposer();
    offers.value = null;
    fetchOffer();
  }

  Future<void> refreshTopItem() async {
    topItemsNetworkError.value = false;
    await topItemCounterDisposer();
    topItems.value = null;
    fetchTopItems();
  }

  Future<void> refreshDiscounts() async {
    discountNetworkError.value = false;
    await discountCounterDisposer();
    discounts.value = null;
    fetchDiscounts();
  }

  Future<void> refreshNewItem() async {
    newItemsNetworkError.value = false;
    await newItemCounterDisposer();
    newItems.value = null;
    fetchNewItem();
  }

  void isEndOfOfferList() {
    if (offerListController.position.pixels ==
        offerListController.position.maxScrollExtent) {
      fetchOffer();
    }
  }

  void isEndOfDiscountsItemList() {
    if (discountListController.position.pixels ==
        discountListController.position.maxScrollExtent) {
      fetchDiscounts();
    }
  }

  void isEndOfTopItemsList() {
    if (topItemsListController.position.pixels ==
        topItemsListController.position.maxScrollExtent) {
      fetchTopItems();
    }
  }

  void isEndOfVerticalList() {
    if (verticalController.position.pixels ==
        verticalController.position.maxScrollExtent) {
      fetchNewItem();
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (AppServices.missingDataException()) {
      showDelayDialog('Missing data, please login again', 3).then((_) {});
    }
  }

  @override
  void onClose() {
    verticalController.dispose();
    topItemsListController.dispose();
    discountListController.dispose();
    // offerListController.dispose();
    super.onClose();
  }
}
