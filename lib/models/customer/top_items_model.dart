class TopItemsModel {
  final String image;
  final String rate;
  final int itemId;
  final bool hasDiscount;
  TopItemsModel({
    required this.image,
    required this.rate,
    required this.itemId,
    required this.hasDiscount,
  });

  factory TopItemsModel.fromJson(Map<String, dynamic> json) {
    return TopItemsModel(
      image: json['image'] as String,
      rate: json['rate'] as String,
      itemId: json['itemId'] as int,
      hasDiscount: json['has_discount'] as bool,
    );
  }
}
