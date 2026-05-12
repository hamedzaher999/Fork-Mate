class CouponModel {
  final int id;
  final String type;
  final String couponNumber;
  final double discount;
  final String remainingTime;
  final DateTime createdAt;
  final bool seen;
  final String tag;

  CouponModel({
    required this.id,
    required this.type,
    required this.couponNumber,
    required this.discount,
    required this.remainingTime,
    required this.createdAt,
    required this.seen,
  }) : tag = '$type#$id';

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      couponNumber: json['coupon_number'],
      type: json['type'],
      discount: (json['discount'] as num).toDouble(),
      remainingTime: json['remainingTime'],
      seen: json['seen'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'coupon_number': couponNumber,
      'discount': discount,
      'remainingTime': remainingTime,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
