import 'package:fork_mate/models/customer/order_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class AppServices extends GetxService {
  static const _themeKey = 'themeMode';
  static const _lunKey = 'languageKey';
  static const _name = 'name';
  static const _userName = 'userName';
  static const _phoneNumber = 'phoneNumber';
  static const _token = 'token';
  static const _defaultLocation = 'defaultLocation';
  // static const _orders = 'orders';

  static late Box personalBox;
  static late Box ordersBox;
  static late Box locationBox;
  static late Box appBox;
  //---
  static late ThemeMode themeMode;
  static late Locale appLocale;

  //--
  static Map<String, dynamic>? defaultLocation;
  static Map<int, OrderModel>? cart;
  //---
  static String? name;
  static String? userName;
  static String? phoneNumber;
  static String? token;

  static Future<bool> clear() async {
    try {
      await personalBox.clear();
      await ordersBox.clear();
      await locationBox.clear();
      await appBox.clear();
      name = null;
      userName = null;
      phoneNumber = null;
      token = null;
      return true;
    } catch (_) {
      return false;
    }
  }

  static bool missingDataException() {
    if (name == null ||
        userName == null ||
        phoneNumber == null ||
        token == null) {
      return true;
    }
    return false;
  }

  Future<void> start() async {
    await Hive.openBox('personalBox');
    await Hive.openBox('ordersBox');
    await Hive.openBox('locationBox');
    await Hive.openBox('appBox');
    //--
    personalBox = Hive.box('personalBox');
    ordersBox = Hive.box('ordersBox');
    locationBox = Hive.box('locationBox');
    appBox = Hive.box('appBox');
    await loadThemeMode();
    await loadLanguage();
    await getUserDetails();
    await getDefaultLocation();
    await getToken();
  }

  // static Future<void> saveCart(Map<int, OrderModel> cart) async {
  //   await ordersBox.put(_orders, cart);
  // }

  // static Future<void> getCart() async {
  //   cart = Map<int, OrderModel>.from(await ordersBox.get(_orders));
  //   print(cart);
  //   print('////////////////////////////////////');
  // }

  static Future<bool> setToken(String newToken) async {
    try {
      await personalBox.put(_token, newToken);
      token = newToken;
    } catch (_) {
      return false;
    }
    return true;
  }

  static Future<bool> getToken() async {
    try {
      token = personalBox.get(_token);
    } catch (_) {
      return false;
    }
    return true;
  }

  static Future<void> getUserDetails() async {
    name = personalBox.get(_name);
    userName = personalBox.get(_userName);
    phoneNumber = personalBox.get(_phoneNumber);
  }

  static Future<bool> setUserDetails({
    required String newName,
    required String newUserName,
    required String newPhoneNumber,
  }) async {
    try {
      await personalBox.put(_name, newName);
      await personalBox.put(_userName, newUserName);
      await personalBox.put(_phoneNumber, newPhoneNumber);
      name = newName;
      userName = newUserName;
      phoneNumber = newPhoneNumber;
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> setDefaultLocation(
    LatLng latLng,
    String? locationName,
  ) async {
    defaultLocation = {
      'Lat': latLng.latitude,
      'Lng': latLng.longitude,
      'locationName': locationName ?? 'Unknown',
    };
    try {
      await locationBox.put(_defaultLocation, defaultLocation);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<LatLng?> getDefaultLocation() async {
    try {
      final data = locationBox.get(_defaultLocation);
      defaultLocation = data != null ? Map<String, dynamic>.from(data) : null;
      if (defaultLocation?['Lat'] != null && defaultLocation?['Lng'] != null) {
        return LatLng(defaultLocation!['Lat'], defaultLocation!['Lng']);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  static Future<bool> saveThemeMode(String mode) async {
    try {
      await appBox.put(_themeKey, mode);

      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> loadThemeMode() async {
    try {
      final mode = appBox.get(_themeKey);
      if (mode == 'dark') {
        themeMode = ThemeMode.dark;
      } else if (mode == 'light') {
        themeMode = ThemeMode.light;
      } else {
        themeMode = ThemeMode.system;
      }
    } catch (_) {
      themeMode = ThemeMode.system;
    }
  }

  static Future<bool> saveLanguage(String lang) async {
    try {
      await appBox.put(_lunKey, lang);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> loadLanguage() async {
    try {
      final lang = appBox.get(_lunKey);
      appLocale = Locale(lang ?? 'ar');
      return true;
    } catch (_) {
      appLocale = Locale('ar');
      return false;
    }
  }

  static Future<AppServices> init() async {
    return Get.putAsync<AppServices>(() async {
      final service = AppServices();
      await service.start();
      return service;
    });
  }
}
