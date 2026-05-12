import 'package:flutter/material.dart';
import 'package:fork_mate/app/app.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/get_current_location.dart';
import 'package:fork_mate/functions/get_default_location.dart';
import 'package:fork_mate/models/customer/advertisement_model.dart';
import 'package:fork_mate/models/customer/location_model.dart';
import 'package:fork_mate/utils/check_location_permission.dart';
import 'package:fork_mate/view/customer/pages/cart_page.dart';
import 'package:fork_mate/view/customer/pages/customer_home_page.dart';
import 'package:fork_mate/view/customer/pages/notifications_page.dart';
import 'package:fork_mate/view/customer/pages/services_page.dart';
import 'package:fork_mate/view/customer/pages/setting_page.dart';
import 'package:get/get.dart';

const String cashOnDelivery = 'cash on delivery';
const String onlinePayment = 'online payment';
const String pointsMethod = 'points';
const String currentLocation = 'current location';
const String restaurantPickup = 'restaurant pickup';
const String defaultLocation = 'default location';
const String selectLocationOnMap = 'select on map';

final orderStatus = ['Pending', 'In Progress', 'Canceled'];

enum ProductType { item, offer, coupon, gift }

enum ItemType {
  offer,
  // discountItem,
  // topItem,
  item,
  gift,
  discountCoupon,
  freeDeliveryCoupon,
}

enum Pages {
  home(Icons.home),
  services(Icons.search),
  cart(Icons.shopping_cart),
  notifications(Icons.notifications),
  settings(Icons.person);

  // Fields
  final IconData icon;
  // Constructor
  const Pages(this.icon);

  Widget get page {
    switch (this) {
      case Pages.home:
        return CustomerHomePage();
      case Pages.services:
        return ServicesPage();
      case Pages.cart:
        return CartPage();
      case Pages.notifications:
        return NotificationsPage();
      case Pages.settings:
        return SettingPage();
    }
  }
}

Map<String, Function> paymentMethods = {
  onlinePayment: () {},
  cashOnDelivery: () {},
  pointsMethod: () {
    Get.find<OrderDetailsController>().payByPoints();
  },
};
final Map<String, Future<LocationsModel?> Function()> deliveryMethods = {
  defaultLocation: getDefaultLocation,
  currentLocation: getCurrentLocation,
  selectLocationOnMap: () async {
    if (!await LocationPermissionChecker.quickCheck()) {
      createSnackBar(message: 'please apply location services');
      LocationPermissionChecker.start();
      return null;
    }
    final result = await Get.toNamed('/locationPage');
    LocationsModel? location = result as LocationsModel?;
    return location;
  },
  restaurantPickup: () async {
    return LocationsModel(
      latLng: storeLocation,
      distance: 0,
      duration: 0,
      route: [],
    );
  },
};
const List<String> advertisementImages = [
  'assets/image/dilvery.jpg',
  'assets/image/cash.jpg',
  'assets/image/archive.jpg',
];
List<AdvertisementModel> localAdvertisementImages = [
  AdvertisementModel(image: 'assets/image/dilvery.jpg', type: 'local'),
  AdvertisementModel(image: 'assets/image/cash.jpg', type: 'local'),
  AdvertisementModel(image: 'assets/image/archive.jpg', type: 'local'),
];

const List<String> paymentMethod = [onlinePayment, cashOnDelivery];
const List<String> deliveryMethod = [
  currentLocation,
  defaultLocation,
  selectLocationOnMap,
];
