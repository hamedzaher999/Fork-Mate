import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/category_model.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/models/customer/services_model.dart';

class ServicesClass {
  static Future<List<ServiceModel>?> getServices() async {
    try {
      final url = Uri.parse('$baseURL/services');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<ServiceModel> services = jsonList
            .map((jsonItem) => ServiceModel.fromJson(jsonItem))
            .toList();
        return services;
      } else {
        throw Exception("Network error: services returned null");
      }
    } catch (e) {
      throw Exception("Network error: services returned null");
    }
  }

  static Future<List<CategoryModel>?> getServiceCategories(
    int serviceId,
  ) async {
    try {
      final url = Uri.parse('$baseURL/serviceCategory/$serviceId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((jsonItem) => CategoryModel.fromJson(jsonItem))
            .toList();
      } else {
        throw Exception("Network error: categories returned null");
      }
    } catch (e) {
      throw Exception("Network error: categories returned null");
    }
  }

  static Future<List<ItemModel>> getItems(int serviceId, int categoryId) async {
    try {
      final url = Uri.parse('$baseURL/servicesCategory/$serviceId/$categoryId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((jsonItem) => ItemModel.fromJson(jsonItem))
            .toList();
      } else {
        throw Exception("Network error: item returned null");
      }
    } catch (e) {
      throw Exception("Network error: item returned null");
    }
  }

  static Future<List<ItemModel>?> searchByName(String itemName) async {
    try {
      final url = Uri.parse('$baseURL/search/$itemName');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((jsonItem) => ItemModel.fromJson(jsonItem))
            .toList();
      } else {
        throw Exception("Network error: item search null");
      }
    } catch (e) {
      throw Exception("Network error: search null");
    }
  }
}
