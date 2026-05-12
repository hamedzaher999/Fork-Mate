import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/functions/search.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/services/customer/services.dart';

class SearchRequestController extends GetxController {
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  //fetching key to avoid search conflict
  String queryKey = '';
  //------------
  RxBool searchNetworkError = false.obs;
  RxString display = 'local'.obs;

  Rx<List<ItemModel>> localFoundItem = Rx<List<ItemModel>>([]);
  Rx<List<ItemModel>?> serverFoundItem = Rx<List<ItemModel>?>(null);

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      focusNode.requestFocus();
    });
    super.onInit();
  }

  void search() {
    display.value = 'local';
    localFoundItem.value = localSearch(textController.text);
  }

  Future<void> serverSearch() async {
    if (textController.text.trim().isEmpty) return;
    String key = UniqueKey().toString();
    focusNode.unfocus();
    queryKey = key;
    display.value = 'server';
    searchNetworkError.value = false;
    serverFoundItem.value = null;
    try {
      List<ItemModel>? foundItem = await ServicesClass.searchByName(
        textController.text,
      );
      if (queryKey == key) {
        serverFoundItem.value = foundItem;
      }
    } catch (e) {
      searchNetworkError.value = true;
    }
  }
}
