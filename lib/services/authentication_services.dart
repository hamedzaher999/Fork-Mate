import 'dart:convert';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/show_waiting_pop_scope.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fork_mate/app/colors.dart';

class AuthenticationServices {
  static Future<Map<String, dynamic>> isUsernameAvailable({
    required String username,
  }) async {
    final url = Uri.parse('$baseURL/isUsernameAvailable');
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
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> deleteAccount({
    required String password,
  }) async {
    final url = Uri.parse('$baseURL/deleteAccount');
    //reject
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
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> signup({
    required String number,
    required String userName,
    required String password,
    required String code,
  }) async {
    final url = Uri.parse('$baseURL/signup');
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
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> login({
    required String usernameOrNumber,
    required String password,
  }) async {
    final url = Uri.parse('$baseURL/login');
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
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> isNumberAvailable({
    required String number,
  }) async {
    final url = Uri.parse('$baseURL/isNumberAvailable');
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
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> changePasswordWithCodeAndNumber({
    required String number,
    required String code,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseURL/changePasswordWithCodeAndNumber');
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
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> getVerificationCodeByNumber({
    required String number,
  }) async {
    //verify
    final url = Uri.parse('$baseURL/sendCode/number=');
    // final body = jsonEncode({
    //   'name': name,
    //   'username': userName,
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
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception('network error');
      }
    } catch (e) {
      throw Exception('network error');
    }
  }

  static Future<Map<String, dynamic>> changePasswordWithOldPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseURL/changePassword');

    // final body = jsonEncode({
    //   'old_password': oldPassword,
    //   'new_password': newPassword,
    //   'confirm_password': confirmPassword,
    // });
    showWaitingPopScope();
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN_HERE',
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
      createSnackBar(message: 'Network error. Please try again.');
      throw Exception('network error');
    }
  }
}
