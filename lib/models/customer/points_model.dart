class PointsModel {
  final double pointsCount;
  final double pricePerPoint;

  PointsModel({required this.pointsCount, required this.pricePerPoint});

  double pointValue() {
    return pointsCount * pricePerPoint;
  }

  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      pointsCount: (json['myPoints'] ?? 0).toDouble(),
      pricePerPoint: (json['pointPrice'] ?? 0).toDouble(),
    );
  }
}
