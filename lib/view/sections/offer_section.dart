import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/view/customer/fork_indicator.dart';
import 'package:fork_mate/view/customer/widget/gradient_tape.dart';
import 'package:fork_mate/view/shared_widget/mini_circular_indicator.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fork_mate/controller/customer_home_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/network_error.dart';
import 'package:fork_mate/view/customer/widget/offer_box.dart';
import 'package:fork_mate/view/shimmers/offer_box_shimmer.dart';

class OfferSection extends StatelessWidget {
  OfferSection({super.key});
  final CustomerHomePageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(ForkIndicator());
          },
          child: GradientTape(
            text: 'offers'.tr,
            icon: MdiIcons.tagOutline,
            tapeWidth: SizeConfig.height * 0.03,
          ),
        ),
        SizedBox(
          height: SizeConfig.height * 0.17,
          child: GetX<CustomerHomePageController>(
            builder: (controller) {
              if (controller.offersNetworkError.value) {
                return NetworkError(
                  onTap: () {
                    controller.refreshOffers();
                  },
                );
              }
              if (controller.offers.value == null) {
                return Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(child: OfferBoxShimmer()),
                );
              }
              if (controller.offers.value!.isNotEmpty) {
                return ListView.separated(
                  controller: controller.offerListController,
                  separatorBuilder: (_, _) =>
                      SizedBox(width: SizeConfig.sidePadding),
                  padding: EdgeInsetsDirectional.all(SizeConfig.sidePadding),
                  itemCount: controller.offers.value!.length + 1,
                  itemBuilder: (_, index) =>
                      index < controller.offers.value!.length
                      ? OfferBox(offer: controller.offers.value![index])
                      : Center(
                          child: Obx(
                            () => controller.isOffersFetching.value
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: SizeConfig.sidePadding,
                                    ),
                                    child: MiniCircularIndicator(
                                      color: elegantYellow,
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ),
                  scrollDirection: Axis.horizontal,
                );
              }
              return SizedBox(
                height: SizeConfig.height * 0.1,
                width: SizeConfig.width,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('sold out'.tr),
                      SizedBox(width: SizeConfig.height * 0.02),
                      Icon(MdiIcons.tagOff, size: SizeConfig.fontRegular),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
