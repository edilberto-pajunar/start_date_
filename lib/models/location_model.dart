import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String placeId;
  final String name;
  final num lat;
  final num lon;

  const Location({
    this.placeId = "",
    this.name = "",
    required this.lat,
    required this.lon,
  });

  static const initialLocation = Location(lat: 0, lon: 0);

  Location copyWith({
    String? placeId,
    String? name,
    num? lat,
    num? lon,
  }) {
    return Location(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    if (json.keys.contains("place_id")) {
      return Location(
        placeId: json["place_id"],
        name: json["name"],
        lat: json["geometry"]["location"]["lat"],
        lon: json["geometry"]["location"]["lng"],
      );
    } else {
      return Location(
        placeId: json["placeId"],
        name: json["name"],
        lat: num.parse(json["lat"].toString()),
        lon: num.parse(json["lon"].toString()),
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "placeId": placeId,
      "name": name,
      "lat": lat,
      "lon": lon,
    };
  }

  @override
  List<Object?> get props => [
        placeId,
        name,
        lat,
        lon,
      ];
}
