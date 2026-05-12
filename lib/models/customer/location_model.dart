import 'package:latlong2/latlong.dart';

class LocationsModel {
  String? targetName;
  final LatLng latLng;
  final double distance;
  final double duration;
  final List<LatLng> route;
  double price = 0;
  LocationsModel({
    required this.latLng,
    required this.distance,
    required this.duration,
    required this.route,
    this.targetName,
  });

  double calculatePrice(double price) {
    this.price = distance * price;
    return price;
  }

  factory LocationsModel.fromJson(
    Map<String, dynamic> json,
    LatLng latLng,
    String? locationName,
  ) {
    final properties = json['features'][0]['properties']['segments'][0];
    final geometry = json['features'][0]['geometry']['coordinates'] as List;

    return LocationsModel(
      latLng: latLng,
      targetName: locationName,
      distance: (properties['distance'] as num).toDouble(),
      duration: (properties['duration'] as num).toDouble(),
      route: geometry
          .map(
            (c) => LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()),
          )
          .toList(),
    );
  }
  Map toJson() {
    return {
      'name': targetName,
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
      'distance': distance,
    };
  }
}
