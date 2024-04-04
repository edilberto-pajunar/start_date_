import 'package:start_date/models/user_model.dart';
import 'package:start_date/models/match_model.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);
  Stream<List<User>> getUsersToSwipe(User user);
  Stream<List<User>> getUsers(User user);
  Stream<List<Match>> getMatches(User user);
  Future<void> createUser(User user);

  Future<void> updateUser(User user);
  Future<void> updateUserPictures(User user, String imageName);
  Future<void> updateUserSwipe(
    User currentUser,
    User user,
    bool isSwipeRight,
  );
  Future<void> updateUserMatch(User currentUser, User user);

  Future<void> updateCode(User user, String generateCode);
  Future<void> updateJoinPartner(User currentUser, String generatedCode);
}
