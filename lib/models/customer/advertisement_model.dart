class AdvertisementModel {
  final String image;
  final String type;

  AdvertisementModel({required this.image, this.type = 'network'});

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(image: json['image']);
  }
}
