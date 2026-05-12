class RunningOrderModel {
  final int orderId;
  final double finalPrice;
  final double contentPrice;
  final bool isGift;
  final String orderStatus;
  final String orderPaymentStatus;
  final String createdAt;
  final String? deliveredAt;
  final bool canCancel;
  //--
  final List<SentItem> items;
  final List<SentOffer> offers;
  final List<SentGift> gifts;
  //--
  final Map<String, double> usedCoupon;
  final Map<String, double> usedCode;
  final bool freeDeliveryCoupons;
  //----
  final DeliveryDetails deliveryDetails;
  final PaymentDetails paymentDetails;
  //--
  final String? cancelMessage;
  RunningOrderModel({
    required this.orderId,
    required this.canCancel,
    required this.finalPrice,
    required this.contentPrice,
    required this.isGift,
    required this.orderStatus,
    required this.orderPaymentStatus,
    required this.createdAt,
    required this.deliveredAt,
    required this.items,
    required this.offers,
    required this.gifts,
    required this.usedCoupon,
    required this.usedCode,
    required this.freeDeliveryCoupons,
    required this.deliveryDetails,
    required this.paymentDetails,
    required this.cancelMessage,
  });

  factory RunningOrderModel.fromJson(Map<String, dynamic> json) {
    return RunningOrderModel(
      orderId: json['order_id'],
      canCancel: json['can_cancel'],
      finalPrice: (json['final_price'] as num).toDouble(),
      isGift: json['is_gift'],
      orderStatus: json['order_status'],
      orderPaymentStatus: json['order_payment_status'],
      createdAt: json['created_at'],
      deliveredAt: json['delivered_at'],

      freeDeliveryCoupons: json['free_delivery_coupons'],
      usedCode: Map<String, double>.from(json['used_discount_code']),
      usedCoupon: Map<String, double>.from(json['used_coupons']),
      cancelMessage: json['cancel_message'],
      deliveryDetails: DeliveryDetails.fromJson(json['delivery']),
      paymentDetails: PaymentDetails.fromJson(json['payment']),
      contentPrice: (json['content']['content_price'] as num).toDouble(),
      items: (json['content']['items'] as List)
          .map((e) => SentItem.fromJson(e))
          .toList(),
      offers: (json['content']['offers'] as List)
          .map((e) => SentOffer.fromJson(e))
          .toList(),
      gifts: (json['content']['gifts'] as List)
          .map((e) => SentGift.fromJson(e))
          .toList(),
    );
  }
}

class SentItem {
  final int id;
  final String name;
  final int count;
  final double price;
  final List<String> chosenPreference;

  SentItem({
    required this.id,
    required this.name,
    required this.count,
    required this.price,
    required this.chosenPreference,
  });

  factory SentItem.fromJson(Map<String, dynamic> json) {
    return SentItem(
      id: json['id'],
      name: json['name'],
      count: json['count'],
      price: (json['price'] as num).toDouble(),
      chosenPreference: (json['chosenPreference'] as List<dynamic>)
          .cast<String>(),
    );
  }
}

class SentOffer {
  final int id;
  final String name;
  final int count;
  final double price;
  final String description;

  SentOffer({
    required this.id,
    required this.name,
    required this.count,
    required this.price,
    required this.description,
  });

  factory SentOffer.fromJson(Map<String, dynamic> json) {
    return SentOffer(
      id: json['id'],
      name: json['name'],
      count: json['count'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
    );
  }
}

class SentGift {
  final int id;
  final String giftNumber;
  final String description;

  SentGift({
    required this.id,
    required this.giftNumber,
    required this.description,
  });

  factory SentGift.fromJson(Map<String, dynamic> json) {
    return SentGift(
      id: json['id'],
      giftNumber: json['number'],
      description: json['description'],
    );
  }
}

class DeliveryDetails {
  final String method;
  final String deliveryPaymentStatus;
  final LocationDetails? details;
  DeliveryDetails({
    required this.method,
    required this.details,
    required this.deliveryPaymentStatus,
  });

  factory DeliveryDetails.fromJson(Map<String, dynamic> json) {
    return DeliveryDetails(
      method: json['method'],
      deliveryPaymentStatus: json['delivery_payment_status'],
      details: json['location_details'] == null
          ? null
          : LocationDetails.fromJson(json['location_details']),
    );
  }
}

class LocationDetails {
  final String name;
  final double latitude;
  final double longitude;
  final double distance;
  final double price;

  LocationDetails({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.price,
  });

  factory LocationDetails.fromJson(Map<String, dynamic> json) {
    return LocationDetails(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      distance: json['distance'],
      price: json['price'],
    );
  }
}

class PaymentDetails {
  String paymentMethod;
  String paymentStatus;
  String? details;

  PaymentDetails({
    required this.paymentMethod,
    required this.details,
    required this.paymentStatus,
  });
  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      paymentMethod: json['method'] as String,
      paymentStatus: json['payment_status'],
      details: json['details'] as String?,
    );
  }
}
