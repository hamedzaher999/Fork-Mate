import 'dart:convert';

import 'package:fork_mate/app/colors.dart';
import 'package:http/http.dart' as http;

class NotificationsServices {
  static Future<bool> hasRunningOrders() async {
    final Uri url = Uri.parse('$baseURL/hasRunningOrders');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<bool> hasNewGifts() async {
    final Uri url = Uri.parse('$baseURL/hasNewGifts');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<bool> hasNewCoupons() async {
    final Uri url = Uri.parse('$baseURL/hasNewCoupons');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<bool> hasCanceledOrders() async {
    final Uri url = Uri.parse('$baseURL/hasCanceledOrders');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
