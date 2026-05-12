import 'package:fork_mate/app/customer_app.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';

class OfferModel {
  final int id;
  final String name;
  final String description;
  final String remainingTime;
  final double price;
  final int? allowedQuantity;
  final String tag;
  int count = 1;

  Map<String, dynamic> offerDTO() {
    return {'id': id, 'count': count};
  }

  bool increment({int? quantity}) {
    if (allowedQuantity == null) {
      count += quantity ?? 1;
      return true;
    } else if (count + (quantity ?? 1) <= allowedQuantity!) {
      count += quantity ?? 1;
      return true;
    }
    createSnackBar(
      message: ' الحد المسموح  لهذا العرض هو  $allowedQuantity',
      milliSecondDuration: 1500,
    );
    return false;
  }

  void decrement() {
    if (count > 1) {
      count--;
    }
  }

  double totalPrice() {
    return price * count;
  }

  OfferModel clone() {
    OfferModel clone = OfferModel(
      id: id,
      name: name,
      description: description,
      remainingTime: remainingTime,
      price: price,
      allowedQuantity: allowedQuantity,
      type: 'cloned_${ItemType.offer.name}',
    );
    return clone;
  }

  double getTotalPrice() {
    return price * count;
  }

  OfferModel({
    required this.id,
    required this.name,
    required this.description,
    required this.remainingTime,
    required this.price,
    required this.allowedQuantity,
    String? type,
  }) : tag = type == null ? '${ItemType.offer.name}#$id' : '$type#$id';

  factory OfferModel.fromJson(
    Map<String, dynamic> json, {
    required String type,
  }) {
    return OfferModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      remainingTime: json['remaining_time'] as String,
      price: (json['price'] as num).toDouble(),
      allowedQuantity: json['allowed_quantity'],
      type: type,
    );
  }
}
