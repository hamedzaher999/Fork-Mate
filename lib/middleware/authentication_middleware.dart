import 'package:flutter/widgets.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:get/get.dart';

class AuthenticationMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AppServices.token == null) {
      return null;
    } else {
      return RouteSettings(name: '/customerApp');
    }
  }
}
