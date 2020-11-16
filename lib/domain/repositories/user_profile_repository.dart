import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';

abstract class UserProfileRepository {
  Future<String> save(UserProfile userProfile);
  Future<void> update(String id, UserProfile userProfile);
  Future<UserProfile> load(String id);
}
