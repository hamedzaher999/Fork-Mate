class DiscountCodeModel {
  final double discount;
  final String message;
  final bool valid;
  final String code;

  DiscountCodeModel({
    required this.discount,
    required this.message,
    required this.valid,
    required this.code,
  });

  factory DiscountCodeModel.fromJson(Map<String, dynamic> json) {
    return DiscountCodeModel(
      discount: (json['discount'] as num).toDouble(),
      message: json['message'],
      valid: json['valid'],
      code: json['code'],
    );
  }
}
