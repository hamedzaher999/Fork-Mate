import 'dart:convert';

import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/models/customer/category_model.dart';

class ItemModel {
  final int id;
  final String image;
  final String name;
  final double price;
  final String rate;
  final CategoryModel category;
  final List<String> ingredients;
  Discount? discount;
  final List<PreferencesModel> preferences;
  final int myRate;
  final String tag;
  String callBackKey = '';
  //-----
  Map<int, Map<String, double>> chosenPreference = {};
  int count;
  ItemModel({
    required this.id,
    required this.category,
    required this.image,
    required this.name,
    required this.price,
    required this.rate,
    required this.ingredients,
    required this.discount,
    required this.preferences,
    required this.myRate,
    String? type,
    this.count = 1,

    Map<int, Map<String, double>>? chosenPreference,
  }) : chosenPreference = chosenPreference ?? {},
       tag = type == null ? '${ItemType.item.name}#$id' : '$type#$id';
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      category: CategoryModel.fromJson(json['category']),
      image: json['image'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      rate: json['rate'],
      ingredients: List<String>.from(json['ingredients']),
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : null,
      preferences: (json['preference'] as List)
          .map((e) => PreferencesModel.fromJson(e))
          .toList(),
      myRate: json['my_rate'] ?? 0,
    );
  }
  ItemModel clone() {
    ItemModel clone = ItemModel(
      id: id,
      category: category,
      name: name,
      image: image,
      preferences: preferences,
      price: price,
      rate: rate,
      discount: discount,
      ingredients: ingredients,
      myRate: myRate,
      type: 'cloned_${ItemType.item.name}',
    );
    return clone;
  }

  List preferenceDTO() {
    List preference = [];
    for (var entries in chosenPreference.entries) {
      preference.add({
        'id': entries.key,
        'preference': entries.value.keys.toList(),
      });
    }
    return preference;
  }

  Map<String, dynamic> itemDto() {
    return {'id': id, 'count': count, 'chosenPreference': preferenceDTO()};
  }

  String toJson() => jsonEncode({
    'item': id,
    'chosenPreference': chosenPreference.map(
      (key, value) => MapEntry(key.toString(), value),
    ),
  });

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 1) {
      count--;
    }
  }

  double getPriceAfterDiscount() {
    double price = this.price;
    if (discount == null) {
      return price;
    } else {
      double discount = this.discount!.discount;
      return double.parse((price * (discount / 100)).toStringAsFixed(2));
    }
  }

  double getChanges() {
    double changes = 0;
    if (chosenPreference.isEmpty) {
      return 0;
    } else {
      List<int> keys = chosenPreference.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        List<String> values = chosenPreference[keys[i]]!.keys.toList();

        for (int j = 0; j < values.length; j++) {
          changes += chosenPreference[keys[i]]![values[j]]!;
        }
      }
      return changes;
    }
  }

  void addPreference(int id, String type, String name, double changes) {
    chosenPreference.putIfAbsent(id, () => {});
    if (type == 'single-select') {
      chosenPreference[id]!.clear();
    }
    chosenPreference[id]![name] = changes;
  }

  void removePreference(int id, String name) {
    if (chosenPreference[id] != null) {
      chosenPreference[id]!.remove(name);
      if (chosenPreference[id]!.isEmpty) {
        chosenPreference.remove(id);
      }
    }
  }

  double getTotalPrice() {
    double totalPrice = (getPriceAfterDiscount() + getChanges()) * count;

    return totalPrice;
  }
}

class Discount {
  final String type;
  final double discount;
  final String leftTime;

  Discount({
    required this.type,
    required this.discount,
    required this.leftTime,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      type: json['type'],
      discount: (json['discount'] as num).toDouble(),
      leftTime: json['lefttime'],
    );
  }
}

class PreferencesModel {
  final int id;
  final String type;
  final List<PreferenceOption> preference;

  PreferencesModel({
    required this.type,
    required this.preference,
    required this.id,
  });

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    return PreferencesModel(
      id: json['id'],
      type: json['type'],
      preference: (json['preference'] as List)
          .map((e) => PreferenceOption.fromJson(e))
          .toList(),
    );
  }
}

class PreferenceOption {
  final String name;
  final double priceDifference;

  PreferenceOption({required this.name, required this.priceDifference});

  factory PreferenceOption.fromJson(Map<String, dynamic> json) {
    return PreferenceOption(
      name: json['name'],
      priceDifference: (json['price_difference'] as num).toDouble(),
    );
  }
}
