import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/app/customer_app.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fork_mate/models/customer/advertisement_model.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/models/customer/offer_model.dart';

class CustomerHomePageServices {
  static Future<ItemModel> rateItem(int itemId, int rate) async {
    try {
      final response = await http.get(Uri.parse('$baseURL/rate/1/rate=1'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        ItemModel item = ItemModel.fromJson(data);
        return item;
      } else {
        throw Exception('Failed to update rate');
      }
    } catch (e) {
      throw Exception('Failed to update rate');
    }
  }

  static Future<bool> storeStatus() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/storeStatus'));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        bool status = (data['status'] as String) == 'open' ? true : false;
        return status;
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Failed to load offers');
    }
  }

  static Future<List<ItemModel>> fetchDiscounts() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/discounts'));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((offer) => ItemModel.fromJson(offer)).toList();
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Failed to load offers');
    }
  }

  static Future<List<OfferModel>> fetchOffers() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/offers'));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data
            .map(
              (offer) => OfferModel.fromJson(offer, type: ItemType.offer.name),
            )
            .toList();
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Failed to load offers');
    }
  }

  static Future<List<AdvertisementModel>> fetchAdvertisements() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/getAdvertisements'));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((ad) => AdvertisementModel.fromJson(ad)).toList();
      } else {
        throw Exception('Failed to load advertisements');
      }
    } catch (e) {
      throw Exception('Failed to load advertisements');
    }
  }

  static Future<List<ItemModel>> fetchTopItems() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/getTopItems'));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var topItems = data.map((json) => ItemModel.fromJson(json)).toList();
        return topItems;
      } else {
        throw Exception('Failed to load top items');
      }
    } catch (e) {
      throw Exception('Failed to load top items');
    }
  }

  static Future<List<ItemModel>> fetchNewItems() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/newItem'));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        List<ItemModel> itemModels = data
            .map((json) => ItemModel.fromJson(json))
            .toList();

        return itemModels;
      } else {
        throw Exception('fail to reload new items ');
      }
    } catch (e) {
      throw Exception('fail to reload new items ');
    }
  }
}
