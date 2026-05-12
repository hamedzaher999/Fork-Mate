import 'dart:convert';
import 'package:fork_mate/app/colors.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:fork_mate/models/customer/location_model.dart';

class LocationServices {
  static final String apiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjcyYjIwYzNjYWE3MDQ2MDBhZDNjZGRkYjYwN2FkYTc3IiwiaCI6Im11cm11cjY0In0=';

  static Future<double> pricePerMeter() async {
    final url = Uri.parse('$baseURL/pricePerMeter');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['price'];
      } else {
        throw Exception('location error');
      }
    } catch (e) {
      throw Exception('location error');
    }
  }

  static Future<String?> fetchLocationName(LatLng point) async {
    final url = Uri.parse(
      'https://api.openrouteservice.org/geocode/reverse'
      '?api_key=$apiKey'
      '&point.lon=${point.longitude}'
      '&point.lat=${point.latitude}',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['features'] != null && data['features'].isNotEmpty) {
          return data['features'][0]['properties']['name'];
        } else {
          return null;
        }
      } else {
        throw Exception('location error');
      }
    } catch (e) {
      throw Exception('location error');
    }
  }

  static Future<LocationsModel> fetchLocations(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'https://api.openrouteservice.org/v2/directions/cycling-regular'
      '?api_key=$apiKey'
      '&start=${start.longitude},${start.latitude}'
      '&end=${end.longitude},${end.latitude}'
      '&preference=shortest',
    );

    try {
      final response = await http.get(url);
      final String? locationName = await fetchLocationName(end);
      final double price = await pricePerMeter();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        LocationsModel locationModel = LocationsModel.fromJson(
          data,
          end,
          locationName,
        );
        locationModel.calculatePrice(price);
        return locationModel;
      } else {
        throw Exception('location error');
      }
    } catch (e) {
      throw Exception('location error');
    }
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
