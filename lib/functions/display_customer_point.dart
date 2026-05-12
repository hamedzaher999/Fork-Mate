import 'package:flutter/material.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:fork_mate/models/customer/points_model.dart';
import 'package:fork_mate/services/customer/customer_data_services.dart';
import 'package:fork_mate/view/customer/widget/point_box.dart';
import 'package:get/get.dart';

void displayCustomerPoints() async {
  showWaitingPopScope();
  try {
    PointsModel pointsModel = await CustomerDataServices.fetchPoints();
    Get.back();
    Get.dialog(Dialog(child: PointBox(pointsModel: pointsModel)));
  } catch (_) {
    Get.back();
    createSnackBar(networkError: true);
  }
}
