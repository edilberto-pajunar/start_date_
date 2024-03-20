import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final String bio;
  final String jobTitle;
  final List<String> interests;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.bio,
    required this.jobTitle,
    required this.interests,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        bio,
        jobTitle,
      ];

  static List<User> users = [
    const User(
      id: 1,
      name: "Anna",
      age: 25,
      imageUrls: [
        "https://images.unsplash.com/photo-1630557802095-838465e86620?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1710528925809-8f91d349283e?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1597346443982-003bd2bf5f24?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      interests: ["Music", "Politics", "Hiking"],
      bio: "This is Anna's bio",
      jobTitle: "Software Engineer",
    ),
    const User(
      id: 2,
      name: "John",
      age: 30,
      imageUrls: [
        "https://images.unsplash.com/photo-1710528925809-8f91d349283e?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1630557802087-0288adfc7cfd?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1597346443982-003bd2bf5f24?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      interests: ["Music", "Politics", "Hiking"],
      bio: "This is John's bio",
      jobTitle: "Data Analyst",
    ),
    const User(
      id: 3,
      name: "Emily",
      age: 28,
      imageUrls: [
        "https://images.unsplash.com/photo-1630557992628-3d7ac6ef83f5?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1630557802087-0288adfc7cfd?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1597346443982-003bd2bf5f24?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      interests: ["Music", "Politics", "Hiking"],
      bio: "This is Emily's bio",
      jobTitle: "Marketing Manager",
    ),
    const User(
      id: 4,
      name: "Michael",
      age: 35,
      imageUrls: [
        "https://images.unsplash.com/photo-1630558044166-69e54a17a48b?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1630557802087-0288adfc7cfd?q=80&w=3348&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1597346443982-003bd2bf5f24?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      interests: ["Music", "Politics", "Hiking"],
      bio: "This is Michael's bio",
      jobTitle: "Computer Engineer",
    ),
  ];
}
