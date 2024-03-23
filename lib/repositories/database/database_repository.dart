import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/database/base_database_repository.dart';
import 'package:start_date/repositories/storage/storage_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((user) => User.fromSnapshot(user));
  }

  @override
  Future<void> updateUserPictures(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadUrl(user, imageName);

    return _firebaseFirestore.collection("users").doc(user.id).update({
      "imageUrls": FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection("users")
        .doc(user.id)
        .set(user.toMap())
        .then((value) {
      print("User added, ID: ${user.id}");
    });
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection("users")
        .doc(user.id)
        .update(user.toMap())
        .then((value) => print("User document updated."));
  }
}
