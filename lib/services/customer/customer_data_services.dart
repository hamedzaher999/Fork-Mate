import 'dart:convert';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:fork_mate/models/customer/customer_gift_model.dart';
import 'package:fork_mate/models/customer/points_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/coupon_model.dart';

// archive

class CustomerDataServices {
  static Future<Map<String, dynamic>> archive() async {
    final url = Uri.parse('$baseURL/archive');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN_HERE',
        },
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        createSnackBar(message: 'some thing went wrong. Please try again.');
        throw Exception('network error');
      }
    } catch (e) {
      createSnackBar(message: 'Network error. Please try again.');
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> getVerificationCodeByToken() async {
    final url = Uri.parse('$baseURL/resendCode');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN_HERE',
        },
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        createSnackBar(message: 'some thing went wrong. Please try again.');
        throw Exception('network error');
      }
    } catch (e) {
      createSnackBar(message: 'Network error. Please try again.');
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> changePasswordWithCodeAndToken({
    required String code,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseURL/confirmationCode/$code');
    // final body = jsonEncode({
    //   'code': code,
    //   'new_password': newPassword,
    //   'confirm_password': confirmPassword,
    // });
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN_HERE',
        },
        // body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> changePersonalInfo({
    required String name,
    required String userName,
  }) async {
    final url = Uri.parse('$baseURL/changeInformation');
    // final body = jsonEncode({
    //   'name': name,
    //   'username': userName,
    // });
    try {
      showWaitingPopScope();
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ',
        },
        // body: body,
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      Get.back();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        createSnackBar(message: 'some thing went wrong. Please try again.');
        throw Exception('network error');
      }
    } catch (e) {
      Get.back();
      createSnackBar(message: 'Network error. Please try again.');
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> changeNumber({
    required String number,
    required String code,
  }) async {
    final url = Uri.parse('$baseURL/changeNumber');
    // final body = jsonEncode({
    //   'name': name,
    //   'username': userName,
    // });
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ',
        },
        // body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<PointsModel> fetchPoints() async {
    final Uri url = Uri.parse('$baseURL/myPoints');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return PointsModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load coupons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load coupons');
    }
  }

  static Future<List<CouponModel>> fetchCoupons() async {
    final Uri url = Uri.parse('$baseURL/coupons');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        return jsonList.map((json) => CouponModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load coupons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load coupons');
    }
  }

  static Future<List<CouponModel>> fetchFreeDeliveryCoupons() async {
    final Uri url = Uri.parse('$baseURL/freeDeliveryCoupons');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => CouponModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load coupons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load coupons');
    }
  }

  static Future<List<CustomerGiftModel>?> fetchGifts() async {
    final Uri url = Uri.parse('$baseURL/gifts');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        return jsonList
            .map((json) => CustomerGiftModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load gifts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load gifts');
    }
  }

  static Future<bool> setAsSeen({required String type, required int id}) async {
    final Uri url = Uri.parse('$baseURL/setAsSeen');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map jsonList = json.decode(response.body);

        return jsonList['status'] == 'success';
      } else {
        return false;
        // throw Exception('Failed to load gifts: ${response.statusCode}');
      }
    } catch (e) {
      return false;
      // throw Exception('Failed to load gifts');
    }
  }
}
