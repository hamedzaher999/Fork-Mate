import 'package:flutter/material.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/search_request_controller.dart';
import 'package:fork_mate/view/customer/widget/center_message.dart';
import 'package:fork_mate/view/customer/widget/item_box.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/shimmers/item_box_shimmer.dart';

class SearchPage extends GetView<SearchRequestController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomField(
          focusNode: controller.focusNode,
          controller: controller.textController,
          hint: 'search',
          color: Colors.transparent,
          suffix: GestureDetector(
            onTap: controller.serverSearch,
            child: Icon(Icons.search, color: elegantYellow),
          ),
          onSubmitted: controller.serverSearch,
          onChanged: controller.search,
        ),
      ),
      body: Obx(() {
        //if current search in local data
        if (controller.display.value == 'local') {
          return controller.localFoundItem.value.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.localFoundItem.value.length,
                  itemBuilder: (context, index) {
                    return ItemBox(
                      itemModel: controller.localFoundItem.value[index],
                    );
                  },
                )
              : CenterMessage(icon: Icons.search_off);
        }
        //if search query was sent to the server
        else {
          //network error handling
          if (controller.searchNetworkError.value) {
            return NetworkError();
          }
          if (controller.serverFoundItem.value == null) {
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ItemBoxShimmer();
              },
            );
          }
          //display found item
          return controller.serverFoundItem.value!.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.serverFoundItem.value!.length,
                  itemBuilder: (context, index) {
                    return ItemBox(
                      itemModel: controller.serverFoundItem.value![index],
                    );
                  },
                )
              : CenterMessage(
                  message: "We couldn't find the item you're searching for.",
                  icon: Icons.search_off_outlined,
                );
        }
      }),
    );
  }
}
