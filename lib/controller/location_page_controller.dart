import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fork_mate/app/app.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/get_current_location.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:fork_mate/models/customer/location_model.dart';
import 'package:fork_mate/services/customer/location_services.dart';
import 'package:fork_mate/utils/check_location_permission.dart';

class LocationController extends GetxController with WidgetsBindingObserver {
  final MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Rxn<LocationsModel> locationDetails = Rxn(null);
  String searchQueryKey = '';
  //-------------------
  RxBool access = false.obs;
  //--------------
  Rxn<LatLng> myLocation = Rxn(null);

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    LatLng? displayLocation = Get.arguments?['location'];
    if (displayLocation != null) {
      setLocationFromTap(displayLocation);
    }
    checkAccess();
  }

  Future<void> getDefaultLocation() async {
    LatLng? latLng = await AppServices.getDefaultLocation();
    if (latLng != null) {
      myLocation.value = latLng;
      await measure();
    }
  }

  Future<void> setDefaultLocation() async {
    if (locationDetails.value == null) return;
    AppServices.setDefaultLocation(
      locationDetails.value!.latLng,
      locationDetails.value!.targetName,
    ).then((success) {
      if (success) {
        createSnackBar(message: 'has been set as the default location');
      }
    });
  }

  void setLocationFromTap(LatLng point) async {
    if (await LocationPermissionChecker.quickCheck()) {
      myLocation.value = point;
      locationDetails.value = null;
      update();
    } else {
      createSnackBar(message: 'check location permissions');
    }
  }

  void getMyLocation() async {
    locationDetails.value = await getCurrentLocation();

    if (locationDetails.value != null) {
      myLocation.value = locationDetails.value!.latLng;
      if (isClosed) return;
      mapController.move(myLocation.value!, 15);
    }
  }

  Future<void> measure() async {
    showWaitingPopScope();
    try {
      locationDetails.value = await LocationServices.fetchLocations(
        storeLocation,
        myLocation.value!,
      );
      Get.back();
    } catch (e) {
      Get.back();
      createSnackBar(networkError: true);
      return;
    }
  }

  // void startTracking() {
  //   Geolocator.getPositionStream(
  //     locationSettings: const LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 5,
  //     ),
  //   ).listen((Position position) {
  //     latitude.value = position.latitude;
  //     longitude.value = position.longitude;
  //   });
  // }

  Future<void> searchByName() async {
    String key = UniqueKey().toString();
    searchQueryKey = key;

    try {
      searchFocusNode.unfocus();
      showWaitingPopScope();
      final LatLng? result = await LocationServices.searchLocationByName(
        searchController.text,
      );
      if (searchQueryKey != key) return;
      if (result != null) {
        if (isClosed) return;
        mapController.move(result, 15);
        myLocation.value = result;
        locationDetails.value = null;
        Get.back();
      } else {
        Get.back();
        createSnackBar(
          message: 'could not find a location for  "@query"'.trParams({
            'query': searchController.text,
          }),

          milliSecondDuration: 1500,
        );
      }
    } catch (e) {
      Get.back();
      createSnackBar(networkError: true);
      return;
    }
  }

  void checkAccess() async {
    access.value = await LocationPermissionChecker.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // print('hola amigo');
      // print('-------------------------------------------');
      if (Get.isDialogOpen ?? false) return;
      checkAccess();
    }
  }

  @override
  void onClose() {
    mapController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
