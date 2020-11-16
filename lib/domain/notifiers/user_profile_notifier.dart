import 'dart:io';

import 'package:flutter_tdd/domain/repositories/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';
import 'package:state_notifier/state_notifier.dart';

class UserProfilePageNotifier extends StateNotifier<UserProfile>
    with LocatorMixin {
  UserProfilePageNotifier() : super(UserProfile()) {
    Future<void>.delayed(Duration.zero, _configure);
  }

  UserProfileRepository get userProfileRepository =>
      read<UserProfileRepository>();

  UserProfileImageRepository get userProfileImageRepository =>
      read<UserProfileImageRepository>();

  FirebaseAuthRepository get firebaseAuthRepository =>
      read<FirebaseAuthRepository>();

  String get userId => firebaseAuthRepository.loggedInUserId;

  Future<void> _configure() async {
    if (userId != null) {
      await loadProfile(userId);
    }
  }

  Future<void> saveProfile(String id, String name) async {
    if (state != null) {
      state = state.copyWith(id: id, name: name);
    } else {
      state = UserProfile(id: id, name: name);
    }
    await userProfileRepository.save(state);
  }

  Future<void> saveImage(String id, File file) async {
    final storageFile = await userProfileImageRepository.save(file, id);
    if (state != null) {
      state = state.copyWith(image: storageFile);
    } else {
      state = UserProfile(id: id, image: storageFile);
    }
  }

  Future<UserProfile> loadProfile(String id) async {
    final result = await userProfileRepository.load(id);
    state = result;
    return result;
  }
}
