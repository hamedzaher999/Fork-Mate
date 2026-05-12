import 'dart:convert';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:fork_mate/models/customer/discount_code_model.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrdersDetailsServices {
  //
  static Future<Map<String, dynamic>> cancelOrder(int orderID) async {
    final url = Uri.parse('$baseURL/cancelOrder');
    try {
      showWaitingPopScope();
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(response.body);
        await Future.delayed(Duration(seconds: 1));
        Get.back();
        return data;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<bool> sendOrder(Map order) async {
    final url = Uri.parse('$baseURL/order');
    try {
      showWaitingPopScope();
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer",
        },
        // body: jsonEncode(order),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(response.body);
        Get.back();
        createSnackBar(message: data['message'], milliSecondDuration: 3000);
        if (data['status'] == 'success') {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<DiscountCodeModel> useDiscountCode(String code) async {
    final Uri url = Uri.parse('$baseURL/discountCode/$code');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DiscountCodeModel.fromJson(data);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<List<RunningOrderModel>> fetchRunningOrders({
    bool canceled = false,
  }) async {
    final String endPoint = canceled ? 'CO' : 'RO';
    final Uri url = Uri.parse('$baseURL/$endPoint');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((order) => RunningOrderModel.fromJson(order)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
