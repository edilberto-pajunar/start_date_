import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final int age;
  final String gender;
  final List<String> imageUrls;
  final String bio;
  final String jobTitle;
  final List<String> interests;
  final String location;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.imageUrls,
    required this.bio,
    required this.jobTitle,
    required this.interests,
    required this.location,
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
      ];

  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
        id: snap.id,
        name: snap["name"],
        age: snap["age"],
        gender: snap["gender"],
        imageUrls: (snap["imageUrls"] as List).map((e) => e as String).toList(),
        bio: snap["bio"],
        jobTitle: snap["jobTitle"],
        interests: (snap["interests"] as List).map((e) => e as String).toList(),
        location: snap["location"]);

    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
      "imageUrls": imageUrls,
      "bio": bio,
      "jobTitle": jobTitle,
      "interests": interests,
      "location": location,
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
    String? location,
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
    );
  }

  static List<User> users = [
    const User(
      id: "1",
      name: "Anna",
      gender: "Male",
      age: 25,
      imageUrls: [
        "https://plus.unsplash.com/premium_photo-1683121366070-5ceb7e007a97?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1533749047139-189de3cf06d3?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1533749047139-189de3cf06d3?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      interests: ["Music", "Politics", "Hiking"],
      bio: "This is Anna's bio",
      jobTitle: "Software Engineer",
      location: "Makati",
    ),
    const User(
        id: "2",
        name: "John",
        gender: "Female",
        age: 30,
        imageUrls: [
          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "https://images.unsplash.com/photo-1630557802087-0288adfc7cfd?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "https://images.unsplash.com/photo-1541480601022-2308c0f02487?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ],
        interests: ["Music", "Politics", "Hiking"],
        bio: "This is John's bio",
        jobTitle: "Data Analyst",
        location: "Singapore"),
    const User(
        id: "3",
        name: "Emily",
        age: 28,
        gender: "Female",
        imageUrls: [
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "https://images.unsplash.com/photo-1550534791-2677533605ab?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "https://images.unsplash.com/photo-1550534791-2677533605ab?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ],
        interests: ["Music", "Politics", "Hiking"],
        bio: "This is Emily's bio",
        jobTitle: "Marketing Manager",
        location: "Philippines"),
    const User(
      id: "4",
      name: "Michael",
      age: 35,
      gender: "Male",
      imageUrls: [
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://plus.unsplash.com/premium_photo-1677797873738-b9e95d16b41a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://plus.unsplash.com/premium_photo-1677797873738-b9e95d16b41a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      interests: ["Music", "Politics", "Hiking"],
      bio: "This is Michael's bio",
      jobTitle: "Computer Engineer",
      location: "Taiwan",
    ),
  ];
}
