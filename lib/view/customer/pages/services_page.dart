import 'package:flutter/material.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/services_controller.dart';
import 'package:fork_mate/functions/search.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/pages/search_page.dart';
import 'package:fork_mate/view/sections/item_section.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/shared_widget/waiting_indicator.dart';
import 'package:fork_mate/view/shimmers/button_shimmer.dart';
import 'package:fork_mate/view/shimmers/item_box_shimmer.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});
  final ServicesController servicesController = Get.put(
    ServicesController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomField(
          hint: 'search',
          readOnly: true,
          color: Colors.transparent,
          suffix: Icon(Icons.search, color: elegantYellow),
          onTap: () {
            if (servicesController.services.value != null) {
              getAllItems(servicesController.storedItem);
            }
            Get.to(() => SearchPage());
          },
        ),
      ),
      body: GetX<ServicesController>(
        builder: (controller) {
          //while fetching
          if (servicesController.services.value == null) {
            return controller.servicesFetchingError.value
                ? Center(
                    child: NetworkError(
                      onTap: () {
                        servicesController.getServices();
                      },
                    ),
                  )
                : WaitingIndicator();
          }
          return Column(
            children: [
              //service icon section
              SizedBox(
                width: SizeConfig.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: SizeConfig.sidePadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.services.value!.map((service) {
                        return GestureDetector(
                          onTap: () {
                            controller.setCurrentService(service.id);
                            controller.getServiceCategories(service.id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(SizeConfig.sidePadding),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    service.id ==
                                        controller.currentService.value
                                    ? BorderSide(color: elegantYellow)
                                    : BorderSide.none,
                              ),
                            ),
                            child: Text(service.name),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                // If an error occurred while fetching service categories
                child: controller.categoriesFetchingError.value
                    ? NetworkError(
                        onTap: () {
                          controller.getServiceCategories(
                            controller.currentService.value,
                          );
                        },
                      )
                    // If the service categories haven’t been fetched yet
                    : controller.storedCategories.value[controller
                              .currentService
                              .value] ==
                          null
                    ? Padding(
                        padding: EdgeInsets.only(top: SizeConfig.sidePaddingX2),
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.height * 0.035,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) =>
                                    ButtonShimmer(),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) =>
                                    ItemBoxShimmer(),
                              ),
                            ),
                          ],
                        ),
                      )
                    // If the service categories have already been fetched
                    : ItemSection(),
              ),
            ],
          );
        },
      ),
    );
  }
}
