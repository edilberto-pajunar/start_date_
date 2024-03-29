import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
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
        .where("gender", isNotEqualTo: _selectGender(user))
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
  Stream<List<User>> getUsersToSwipe(User user) {
    return Rx.combineLatest2(getUser(user.id!), getUsers(user), (
      User currentUser,
      List<User> users,
    ) {
      return users.where((user) {
        bool isCurrentUser = user.id == currentUser.id;
        bool wasSwipedLeft = currentUser.swipeLeft!.contains(user.id);
        bool wasSwipedRight = currentUser.swipeRight!.contains(user.id);
        bool isMatch = currentUser.matches!.contains(user.id);
        bool isWithinAgeRange =
            user.age >= currentUser.ageRangePreference![0] &&
                user.age <= currentUser.ageRangePreference![1];
        bool isWithinDistance =
            _getDistance(currentUser, user) <= currentUser.distancePreference;

        if (isCurrentUser) return false;
        if (wasSwipedRight) return false;
        if (wasSwipedLeft) return false;
        if (isMatch) return false;
        if (!isWithinDistance) return false;
        if (!isWithinAgeRange) return false;

        return true;
      }).toList();
    });
  }

  @override
  Stream<List<Match>> getMatches(User user) {
    return Rx.combineLatest2(getUser(user.id!), getUsers(user), (
      User currentUser,
      List<User> users,
    ) {
      return users
          .where((user) => currentUser.matches!.contains(user.id))
          .map((user) => Match(userId: user.id!, matchedUser: user))
          .toList();
    });
  }

  _getDistance(User currentUser, User user) {
    GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    var distanceInKm = geolocator.distanceBetween(
          currentUser.location!.lat.toDouble(),
          currentUser.location!.lon.toDouble(),
          user.location!.lat.toDouble(),
          user.location!.lon.toDouble(),
        ) ~/
        1000;
    return distanceInKm;
  }

  _selectGender(User user) {
    if (user.genderPreference!.isEmpty) {
      return ["Male", "Female"];
    }
    return user.genderPreference;
  }
}
