import 'dart:io';

import 'package:flutter_tdd/domain/repositories/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final userProfileNotifierProviderAutoDispose =
    StateNotifierProvider.autoDispose<UserProfileNotifier>(
        (ref) => UserProfileNotifier(ref.read));

// シングルトン
final userProfileNotifierProvider = StateNotifierProvider<UserProfileNotifier>(
    (ref) => UserProfileNotifier(ref.read));

class UserProfileNotifier extends StateNotifier<UserProfile> with LocatorMixin {
  UserProfileNotifier(this._read) : super(UserProfile()) {
    Future<void>.delayed(Duration.zero, _configure);
  }

  final Reader _read;

  UserProfileRepository get userProfileRepository =>
      _read(userProfileRepositoryProvider);

  UserProfileImageRepository get userProfileImageRepository =>
      _read(userProfileImageRepositoryProvider);

  FirebaseAuthRepository get firebaseAuthRepository =>
      _read(firebaseAuthRepositoryProvider);

  String get userId => firebaseAuthRepository.loggedInUserId;

  Future<void> _configure() async {
    if (userId != null) {
      await loadProfile(userId);
    }
  }

  Future<void> saveProfile(String id, String name) async {
    final data = state.copyWith(id: id, name: name);
    await userProfileRepository.save(data);
    state = data;
  }

  Future<void> saveImage(String id, File file) async {
    final storageFile = await userProfileImageRepository.save(file, id);
    state = state.copyWith(id: id, image: storageFile);
  }

  Future<UserProfile> loadProfile(String id) async {
    final result = await userProfileRepository.load(id);
    state = result;
    return result;
  }
}
