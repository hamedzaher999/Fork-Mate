import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/ads_section_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/local_image_container.dart';
import 'package:fork_mate/view/customer/widget/network_image_container.dart';

class AdvertisementSection extends GetView<AdsControllerController> {
  const AdvertisementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AdsControllerController>(
      builder: (controller) {
        final ads = controller.advertisements;
        controller.startAutoScroll(ads.value.length);

        return SizedBox(
          height: SizeConfig.height * 0.2,
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: ads.value.length,
            padEnds: false,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GetX<AdsControllerController>(
                builder: (animationController) {
                  double scale =
                      (1 -
                              ((animationController.currentPage.value - index)
                                      .abs() *
                                  0.3))
                          .clamp(0.8, 1.0);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: SizeConfig.width,
                      margin: EdgeInsetsDirectional.only(
                        start: SizeConfig.width * 0.04,
                      ),

                      child:
                          controller.advertisements.value[index].type ==
                              'network'
                          ? NetworkImageContainer(
                              imageURL:
                                  controller.advertisements.value[index].image,
                              width: SizeConfig.width,
                              height: SizeConfig.height * 0.2,
                            )
                          : LocalImageContainer(
                              imageURL:
                                  controller.advertisements.value[index].image,
                              width: SizeConfig.width,
                              height: SizeConfig.height * 0.2,
                            ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
