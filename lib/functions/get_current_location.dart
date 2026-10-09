import 'package:fork_mate/app/app.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:fork_mate/models/customer/location_model.dart';
import 'package:fork_mate/services/customer/location_services.dart';
import 'package:fork_mate/utils/check_location_permission.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:latlong2/latlong.dart';

Future<LocationsModel?> getCurrentLocation() async {
  if (!await LocationPermissionChecker.quickCheck()) {
    bool confirm = await confirmationDialog(
      message: 'please enable location services',
      confirmText: 'enable',
    );
    if (confirm) LocationPermissionChecker.start();
    return null;
  }
  showWaitingPopScope();
  try {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).timeout(const Duration(seconds: 15));
    LocationsModel? locationsModel = await LocationServices.fetchLocations(
      storeLocation,
      LatLng(position.latitude, position.longitude),
    );
    Get.back();
    return locationsModel;
  } catch (_) {
    Get.back();

    createSnackBar(networkError: T);
    return null;
  }
}
