import 'package:app_settings/app_settings.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionChecker {
  static Future<bool> quickCheck() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> start() async {
    if (await quickCheck()) return true;
    if (await checkPermission()) {
      return checkLocationService();
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return checkLocationService();
      }
    }
    return false;
  }

  //--
  static Future<bool> checkPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return true;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          await confirmationDialog(
            message: 'please enable location services',
            confirmText: 'enable',
          ).then((confirm) {
            if (confirm) {
              AppSettings.openAppSettings();
            }
          });
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await confirmationDialog(
          message: 'please enable location services',
          confirmText: 'enable',
        ).then((confirm) {
          if (confirm) {
            AppSettings.openAppSettings();
          }
        });
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> checkLocationService() async {
    try {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) return true;

      confirmationDialog(
        message: 'please enable location services',
        confirmText: 'enable',
      ).then((confirm) async {
        if (confirm) {
          try {
            await Geolocator.openLocationSettings();
          } catch (_) {
            return;
          }
        } else {
          return;
        }
      });
      return false;
    } catch (_) {
      return false;
    }
  }
}
