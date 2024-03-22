import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/database/base_database_repository.dart';
import 'package:start_date/repositories/storage/storage_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection("users")
        .doc("bEeJ8vLlZEJN9MJnJMf6")
        .snapshots()
        .map((user) => User.fromSnapshot(user));
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadUrl(imageName);

    return _firebaseFirestore
        .collection("users")
        .doc("bEeJ8vLlZEJN9MJnJMf6")
        .update({
      "imageUrls": FieldValue.arrayUnion([downloadUrl])
    });
  }
}
