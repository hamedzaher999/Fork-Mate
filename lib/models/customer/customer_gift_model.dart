class CustomerGiftModel {
  final int id;
  final String description;
  final String giftNumber;
  final DateTime createdAt;
  final bool seen;

  CustomerGiftModel({
    required this.id,
    required this.description,
    required this.giftNumber,
    required this.seen,
    required this.createdAt,
  });

  factory CustomerGiftModel.fromJson(Map<String, dynamic> json) {
    return CustomerGiftModel(
      id: json['id'],
      description: json['description'],
      giftNumber: json['gift_number'],
      seen: json['seen'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
