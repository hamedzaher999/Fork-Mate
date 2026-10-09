import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:fork_mate/models/customer/location_model.dart';

class LocationServices {
  static const String apiKey = String.fromEnvironment('ORS_API_KEY');
  static Future<String?> fetchLocationName(LatLng point) async {
    final url = Uri.parse(
      'https://api.openrouteservice.org/geocode/reverse'
      '?api_key=$apiKey&point.lon=${point.longitude}&point.lat=${point.latitude}',
    );
    final response = await http.get(url);
    debugPrint('ORS name ${response.statusCode}: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('name ${response.statusCode}');
    }
    final data = jsonDecode(response.body);
    final features = data['features'] as List?;
    if (features == null || features.isEmpty) return null;
    final p = features[0]['properties'];
    return (p['name'] ?? p['label']) as String?;
  }

  static Future<double> pricePerMeter() async {
    final response = await http.get(Uri.parse('$baseURL/pricePerMeter'));
    debugPrint('price ${response.statusCode}: ${response.body}');
    if (response.statusCode != 200)
      throw Exception('price ${response.statusCode}');
    return (jsonDecode(response.body)['price'] as num).toDouble();
  }

  static Future<LocationsModel> fetchLocations(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'https://api.openrouteservice.org/v2/directions/cycling-regular'
      '?api_key=$apiKey'
      '&start=${start.longitude},${start.latitude}'
      '&end=${end.longitude},${end.latitude}'
      '&preference=shortest',
    );
    final response = await http.get(url);
    debugPrint('ORS route ${response.statusCode}: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('route ${response.statusCode}');
    }

    String? name;
    try {
      name = await fetchLocationName(end);
    } catch (e) {
      debugPrint('name failed: $e');
    }
    final price = await pricePerMeter();

    final model = LocationsModel.fromJson(jsonDecode(response.body), end, name);
    model.calculatePrice(price);
    return model;
  }

  static Future<LatLng?> searchLocationByName(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5&bounded=1&viewbox=35.61,33.82,36.32,33.72',
    );

    try {
      final response = await http.get(
        url,
        headers: {"User-Agent": "flutter_map_location_picker_app"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]["lat"]);
          final lon = double.parse(data[0]["lon"]);
          return LatLng(lat, lon);
        }
      }
      return null;
    } catch (e) {
      throw Exception('location error');
    }
  }

  // [
  //   {
  //     "place_id": "12345",
  //     "lat": "33.5138",
  //     "lon": "36.2765",
  //     "display_name": "Damascus, Syria",
  //     "type": "city"
  //   }
  // ]
}
