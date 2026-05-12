import 'package:flutter/material.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/display_customer_point.dart';
import 'package:fork_mate/view/customer/pages/archive_page.dart';
import 'package:fork_mate/view/customer/widget/default_location_box.dart';
import 'package:fork_mate/view/customer/widget/language_box.dart';
import 'package:fork_mate/view/customer/widget/theme_box.dart';
import 'package:get/get.dart';
import 'package:fork_mate/view/customer/pages/coupons_page.dart';
import 'package:fork_mate/view/customer/pages/gifts_page.dart';
import 'package:latlong2/latlong.dart';

final List<String> themes = ['light', 'dark'];

Map<String, List<Map<String, dynamic>>> settings = {
  'Benefits': benefits,
  'Customization': customization,
  'Support': support,
};

List<Map<String, dynamic>> customization = [
  {
    'name': 'Archive',
    'icon': Icons.archive,
    'onTap': () {
      Get.to(() => ArchivePage());
    },
  },
  {
    'name': 'default location',
    'icon': Icons.person_pin_circle_sharp,
    'onTap': () async {
      if (AppServices.defaultLocation == null) {
        confirmationDialog(
          message:
              "you haven't set a default location yet. would you like to set one now?"
                  .tr,
        ).then((confirm) {
          if (confirm) {
            Get.toNamed('/locationPage');
          }
        });
      } else {
        Get.dialog(Dialog(child: DefaultLocationBox()));
      }
    },
  },
  {
    'name': 'Theme',
    'icon': Icons.sunny,
    'onTap': () {
      Get.dialog(Dialog(child: ThemeBox()));
    },
  },
  {
    'name': 'Language',
    'icon': Icons.language,
    'onTap': () {
      Get.dialog(Dialog(child: LanguageBox()));
    },
  },

  {
    'name': 'Password',
    'icon': Icons.password,
    'onTap': () {
      Get.toNamed('/changePasswordPage');
    },
  },
];
List<Map<String, dynamic>> benefits = [
  {
    'name': 'My Coupons',
    'icon': Icons.discount,
    'onTap': () {
      Get.to(() => CouponsPage());
    },
  },
  {
    'name': 'Gifts',
    'icon': Icons.card_giftcard,
    'onTap': () {
      Get.to(() => GiftsPage());
    },
  },
  {
    'name': 'Points',
    'icon': Icons.paid_outlined,
    'onTap': () {
      displayCustomerPoints();
    },
  },
];

List<Map<String, dynamic>> support = [
  {'name': 'Support', 'icon': Icons.support_agent_outlined, 'onTap': () {}},
  {'name': 'Report A Problem', 'icon': Icons.report_problem, 'onTap': () {}},
];
Map<String, String> language = {
  'ar': 'Arabic',
  'en': 'English',
  'es': 'Spanish',
};
const storeLocation = LatLng(33.5, 36.25);
