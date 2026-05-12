import 'package:flutter/material.dart';
import 'package:fork_mate/controller/cart_controller.dart' show CartController;
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:fork_mate/models/customer/category_model.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/models/customer/services_model.dart';
import 'package:fork_mate/services/customer/services.dart';

class ServicesController extends GetxController {
  ScrollController verticalController = ScrollController();
  //fetching  flags
  RxBool isServicesFetching = false.obs;
  RxBool isCategoriesFetching = false.obs;
  RxBool isItemFetching = false.obs;
  RxBool isPagination = false.obs;
  //network error flags
  RxBool servicesFetchingError = false.obs;
  RxBool categoriesFetchingError = false.obs;
  RxBool itemFetchingError = false.obs;
  //mapped data
  Rx<List<ServiceModel>?> services = Rx<List<ServiceModel>?>(null);
  Rx<Map<int, List<CategoryModel>?>> storedCategories =
      Rx<Map<int, List<CategoryModel>?>>({});
  Map<int, Map<int, List<ItemModel>?>> storedItem = {};
  //navigation listener
  Rx<Map<int, int?>> currentCategory = Rx<Map<int, int?>>({});
  RxInt currentService = 0.obs;
  //-----------
  List<ItemModel>? item;
  List<CategoryModel>? categories;

  @override
  void onInit() {
    getServices();
    verticalController.addListener(() {
      isEndOfList();
    });
    super.onInit();
  }

  Future<void> pagination() async {
    isPagination.value = true;
    await Future.delayed(Duration(seconds: 2));
    isPagination.value = false;
  }

  void isEndOfList() {
    if (verticalController.position.pixels ==
        verticalController.position.maxScrollExtent) {
      pagination();
    }
  }

  Future<void> getServices() async {
    servicesFetchingError.value = false;
    if (!isServicesFetching.value) {
      isServicesFetching.value = true;
      // update();

      try {
        services.value = await ServicesClass.getServices();
      } catch (e) {
        servicesFetchingError.value = true;
        return;
      } finally {
        isServicesFetching.value = false;
      }
      if (services.value != null && services.value!.isNotEmpty) {
        currentService.value = services.value!.first.id;
        //initial  services
        for (var service in services.value!) {
          storedItem.putIfAbsent(service.id, () => {});
          storedCategories.value.putIfAbsent(service.id, () => null);
          currentCategory.value.putIfAbsent(service.id, () => null);
        }
        //get the first service categories
        await getServiceCategories(services.value!.first.id);
      }
    }
  }

  Future<void> getServiceCategories(int serviceId) async {
    categoriesFetchingError.value = false;
    if (storedCategories.value[serviceId] == null &&
        !isCategoriesFetching.value) {
      isCategoriesFetching.value = true;
      try {
        categories = await ServicesClass.getServiceCategories(serviceId);
      } catch (e) {
        categoriesFetchingError.value = true;
        return;
      } finally {
        isCategoriesFetching.value = false;
      }
      if (categories != null && categories!.isNotEmpty) {
        storedCategories.value[serviceId] = categories;
        storedCategories.refresh();
        for (var category in categories!) {
          storedItem[serviceId]!.putIfAbsent(category.id, () => null);
        }
        currentCategory.value[serviceId] = categories!.first.id;
        currentCategory.refresh();
        if (storedCategories.value[services.value!.first.id] != null &&
            storedCategories.value[services.value!.first.id]!.isNotEmpty) {
          await getItem(serviceId, storedCategories.value[serviceId]!.first.id);
        }
      }
    }
  }

  Future<void> getItem(int serviceId, int categoryId) async {
    itemFetchingError.value = false;
    if (storedItem[serviceId]![categoryId] == null && !isItemFetching.value) {
      isItemFetching.value = true;

      try {
        List<ItemModel> activator = await ServicesClass.getItems(
          serviceId,
          categoryId,
        );
        // print('$serviceId - $categoryId $activator');
        for (var element in activator) {
          if (element.discount == null) continue;
          element.callBackKey = 'servicePage_${element.tag}';
          void onEnd() {
            element.discount = null;
            Get.find<CartController>().removeDiscountFromItem(element.id);
            currentCategory.refresh();
          }

          //case 1
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
          Get.put(timer, tag: timer.tag);
        }
        item = activator;
      } catch (e) {
        if (categoryId == currentCategory.value[serviceId] &&
            serviceId == currentService.value) {
          itemFetchingError.value = true;
        }
        return;
      } finally {
        isItemFetching.value = false;
      }
      //TODO check why not stoping fetching while empty
      if (item != null) {
        storedItem[serviceId]![categoryId] = item;
        storedCategories.refresh();
      }
    }
  }

  List<CategoryModel>? category(int serviceId) {
    return storedCategories.value[serviceId];
  }

  //set the current category and check if it already has items
  void setCurrentCategory(int serviceId, int categoryId) {
    itemFetchingError.value = false;
    currentCategory.value[serviceId] = categoryId;
    currentCategory.refresh();
    if (storedItem[serviceId]![categoryId] == null) {
      getItem(serviceId, categoryId);
    }
  }

  void setCurrentService(int serviceId) {
    itemFetchingError.value = false;
    categoriesFetchingError.value = false;
    currentService.value = serviceId;
  }

  // Check first if the categories for this service have already been fetched
  List<CategoryModel>? checkCategories(int serviceId) {
    List<CategoryModel>? categories = storedCategories.value[serviceId];
    if (categories == null) {
      getServiceCategories(serviceId);
    }
    return categories;
  }

  // Check first if  there are items of this category
  List<ItemModel>? checkItems(int serviceId, int categoryId) {
    if (storedItem[serviceId]![categoryId] == null) {
      if (!itemFetchingError.value) {
        getItem(serviceId, categoryId);
      }
      return null;
    }
    return storedItem[serviceId]?[categoryId];
  }
}
