import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/database/base_database_repository.dart';
import 'package:start_date/repositories/storage/storage_repository.dart';
import 'package:start_date/models/match_model.dart';

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

  @override
  Stream<List<User>> getUsers(User user) {
    return _firebaseFirestore
        .collection("users")
        .where("gender", isNotEqualTo: "Female")
        // .where(FieldPath.documentId, whereNotIn: userFilter)
        .snapshots()
        .map((snap) {
      return snap.docs.map((user) => User.fromSnapshot(user)).toList();
    });
  }

  @override
  Future<void> updateUserSwipe(
    String userId,
    String matchId,
    bool isSwipeRight,
  ) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection("users").doc(userId).update({
        "swipeRight": FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection("users").doc(userId).update({
        "swipeLeft": FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatch(String userId, String matchId) async {
    await _firebaseFirestore.collection("users").doc(userId).update({
      "matches": FieldValue.arrayUnion([matchId])
    });

    await _firebaseFirestore.collection("users").doc(matchId).update({
      "matches": FieldValue.arrayUnion([userId])
    });
  }

  @override
  Stream<List<Match>> getMatches(User user) {
    List<String> userFilter = List.from(user.matches!)..add("0");

    return _firebaseFirestore
        .collection("users")
        .where(FieldPath.documentId, whereIn: userFilter)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => Match.fromSnapshot(doc, user.id!)).toList();
    });

  }
}
