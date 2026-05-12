import 'package:flutter/material.dart';
import 'package:fork_mate/view/customer/widget/custom_app_bar.dart';
import 'package:fork_mate/view/sections/discount_section.dart';
import 'package:fork_mate/view/sections/new_items_section.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/customer_home_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/sections/advertisements_section.dart';
import 'package:fork_mate/view/sections/offer_section.dart';
import 'package:fork_mate/view/sections/top_item_section.dart';
import 'package:fork_mate/view/shared_widget/section_name_widget.dart';

class CustomerHomePage extends GetView<CustomerHomePageController> {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshPage,
              color: elegantYellow,
              child: CustomScrollView(
                controller: controller.verticalController,
                slivers: [
                  // advertisement section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: SizeConfig.sidePadding),
                      child: AdvertisementSection(),
                    ),
                  ),
                  // offer section
                  SliverToBoxAdapter(child: OfferSection()),
                  // //
                  SliverToBoxAdapter(
                    child: SectionNameWidget(
                      sectionName: 'discounts',
                      prefixIcon: Icons.percent,
                    ),
                  ),
                  SliverToBoxAdapter(child: DiscountSection()),
                  //top item section
                  SliverToBoxAdapter(
                    child: SectionNameWidget(
                      sectionName: 'top',
                      prefixIcon: Icons.diamond_outlined,
                    ),
                  ),
                  SliverToBoxAdapter(child: TopItemSection()),
                  //new item section
                  SliverToBoxAdapter(
                    child: SectionNameWidget(
                      sectionName: 'new',
                      prefixIcon: MdiIcons.fire,
                    ),
                  ),
                  NewItemsSection(),
                  // -----------
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: SizeConfig.height * 0.1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
