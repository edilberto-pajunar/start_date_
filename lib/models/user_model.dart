import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:start_date/models/location_model.dart';
import 'package:start_date/models/partner_model.dart';
import 'package:start_date/models/quality_model.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final int age;
  final String gender;
  final List<String> imageUrls;
  final String bio;
  final String jobTitle;
  final List<String> interests;
  final Location? location;
  final List<String>? swipeLeft;
  final List<String>? swipeRight;
  final List<String>? matches;
  final List<String>? genderPreference;
  final List<int>? ageRangePreference;
  final int? distancePreference;
  final Partner? partner;
  final Quality? quality;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.imageUrls,
    required this.bio,
    required this.jobTitle,
    required this.interests,
    this.location,
    this.swipeLeft,
    this.swipeRight,
    this.matches,
    this.genderPreference,
    this.ageRangePreference,
    this.distancePreference,
    this.partner,
    this.quality,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        gender,
        imageUrls,
        bio,
        jobTitle,
        location,
        swipeRight,
        swipeLeft,
        matches,
        genderPreference,
        ageRangePreference,
        distancePreference,
        partner,
        quality,
      ];

  static const User empty = User(
    id: "",
    name: "",
    age: 0,
    gender: "",
    imageUrls: [],
    bio: "",
    jobTitle: "",
    interests: [],
    location: Location.initialLocation,
    swipeLeft: [],
    swipeRight: [],
    matches: [],
    distancePreference: 10,
    ageRangePreference: [18, 50],
    genderPreference: ["Female"],
    partner: Partner.empty,
    quality: Quality.empty,
  );

  static User fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>?;

    List<String> userGenderPreference = [""];
    List<int> userAgePreference = [];
    int userDistancePreference = 10;

    if (data != null) {
      print(data);
      userGenderPreference = (data["genderPreference"] == null)
          ? ["Male"]
          : (data["genderPreference"] as List)
              .map((gender) => gender as String)
              .toList();

      userAgePreference = (data["ageRangePreference"] == null)
          ? [19, 40]
          : (data["ageRangePreference"] as List)
              .map((age) => age as int)
              .toList();

      userDistancePreference = (data["distancePreference"] == null)
          ? 30
          : data["distancePreference"];
    }
    User user = User(
      id: snap.id,
      name: snap["name"],
      age: snap["age"],
      gender: snap["gender"],
      imageUrls: (snap["imageUrls"] as List).map((e) => e as String).toList(),
      bio: snap["bio"],
      jobTitle: snap["jobTitle"],
      interests: (snap["interests"] as List).map((e) => e as String).toList(),
      location: Location.fromJson(snap["location"]),
      swipeLeft: (snap["swipeLeft"] as List).map((e) => e as String).toList(),
      swipeRight: (snap["swipeRight"] as List).map((e) => e as String).toList(),
      matches: (snap["matches"] as List).map((e) => e as String).toList(),
      genderPreference: userGenderPreference,
      ageRangePreference: userAgePreference,
      distancePreference: userDistancePreference,
      partner: Partner.fromJson(snap["partner"]),
      quality: Quality.fromJson(snap["quality"]),
    );

    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "gender": gender,
      "imageUrls": imageUrls,
      "bio": bio,
      "jobTitle": jobTitle,
      "interests": interests,
      "location": location!.toMap(),
      "swipeLeft": swipeLeft,
      "swipeRight": swipeRight,
      "matches": matches,
      "genderPreference": genderPreference,
      "ageRangePreference": ageRangePreference,
      "distancePreference": distancePreference,
      "partner": partner!.toMap(),
      "quality": quality!.toJson(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    List<String>? imageUrls,
    String? bio,
    String? jobTitle,
    List<String>? interests,
    Location? location,
    List<String>? swipeLeft,
    List<String>? swipeRight,
    List<String>? matches,
    List<String>? genderPreference,
    List<int>? ageRangePreference,
    int? distancePreference,
    Partner? partner,
    Quality? quality,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      interests: interests ?? this.interests,
      location: location ?? this.location,
      swipeLeft: swipeLeft ?? this.swipeLeft,
      swipeRight: swipeRight ?? this.swipeRight,
      matches: matches ?? this.matches,
      genderPreference: genderPreference ?? this.genderPreference,
      ageRangePreference: ageRangePreference ?? this.ageRangePreference,
      distancePreference: distancePreference ?? this.distancePreference,
      partner: partner ?? this.partner,
      quality: quality ?? this.quality,
    );
  }
}
