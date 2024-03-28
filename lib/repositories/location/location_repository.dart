import 'dart:convert';

import 'package:start_date/models/location_model.dart';
import 'package:start_date/repositories/location/base_location_repository.dart';
import 'package:http/http.dart' as http;

class LocationRepository extends BaseLocationRepository {
  final String key = "AIzaSyB2_6HoLIFS87P-Kw2ndpnBjh-FMLD5p5s";
  final String types = "geocode";

  static const baseUrl = "https://maps.googleapis.com/maps/api/place";

  @override
  Future<Location> getLocation(String location) async {
    final String url =
        "$baseUrl/findplacefromtext/json?fields=place_id%2Cname%2Cgeometry&input=$location&inputtype=textquery&key=$key";

    var response = await http.get(
      Uri.parse(url),
    );

    var json = jsonDecode(response.body);
    print(json);
    var results = json["candidates"][0] as Map<String, dynamic>;

    return Location.fromJson(results);
  }
}
