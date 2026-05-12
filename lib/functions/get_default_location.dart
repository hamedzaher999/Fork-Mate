import 'package:fork_mate/app/app.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:fork_mate/models/customer/location_model.dart';
import 'package:fork_mate/services/customer/location_services.dart';
import 'package:fork_mate/utils/check_location_permission.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

Future<LocationsModel?> getDefaultLocation() async {
  if (AppServices.defaultLocation == null) {
    createSnackBar(message: "you haven't set a default location yet.");
    return null;
  }
  bool confirm = await confirmationDialog(
    message:
        'do you want to receive your order in this location : @locationName'
            .trParams({
              'locationName': AppServices.defaultLocation!['locationName'],
            }),
  );
  if (confirm) {
    if (!await LocationPermissionChecker.quickCheck()) {
      LocationPermissionChecker.start();
      return null;
    }
    LatLng latLng = LatLng(
      AppServices.defaultLocation!['Lat'],
      AppServices.defaultLocation!['Lng'],
    );
    showWaitingPopScope();
    try {
      LocationsModel locationsModel = await LocationServices.fetchLocations(
        storeLocation,
        latLng,
      );
      Get.back();
      return locationsModel;
    } catch (e) {
      Get.back();
      createSnackBar(error: true);
    }
  }
  return null;
}
