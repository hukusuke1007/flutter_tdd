import 'dart:io';

import 'package:flutter_tdd/domain/notifiers/index.dart';
import 'package:flutter_tdd/domain/repositories/index.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/entities/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

class MockUserProfileImageRepository extends Mock
    implements UserProfileImageRepository {}

class MockFirebaseAuthRepository extends Mock
    implements FirebaseAuthRepository {}

Future<void> main() async {
  group('UserProfileNotifier', () {
    ProviderContainer container;
    ProviderReference ref;
    const id = 'userId';
    final mockUserProfileRepo = MockUserProfileRepository();
    final mockUserProfileImageRepo = MockUserProfileImageRepository();
    final mockFirebaseAuth = MockFirebaseAuthRepository();
    final storageFile = StorageFile(url: 'image_url');
    final userProfile = UserProfile(
      id: id,
      name: 'mokumoku',
      image: storageFile,
    );
    setUp(() async {
      when(mockUserProfileRepo.save(any)).thenAnswer((_) => Future.value(id));
      when(mockUserProfileRepo.load(any))
          .thenAnswer((_) => Future.value(userProfile));
      when(mockUserProfileImageRepo.save(any, any))
          .thenAnswer((_) => Future.value(storageFile));
      when(mockFirebaseAuth.loggedInUserId).thenReturn(null);

      container = ProviderContainer(
        overrides: [
          userProfileRepositoryProvider.overrideWithValue(mockUserProfileRepo),
          userProfileImageRepositoryProvider
              .overrideWithValue(mockUserProfileImageRepo),
          firebaseAuthRepositoryProvider.overrideWithValue(mockFirebaseAuth),
        ],
      );
      final provider = Provider((ref) => ref);
      ref = container.read(provider);
    });
    /**
     * 正常系
     */
    test('プロフィールを保存', () async {
      final userProfileNotifier = ref.read(userProfileNotifierProvider);

      const name = 'mokumoku';
      await userProfileNotifier.saveProfile(id, name);
      expect(userProfileNotifier.debugState.id, id);
      expect(userProfileNotifier.debugState.name, name);

      verify(mockUserProfileRepo.save(any)).called(1);
    });
    test('プロフィール画像を保存', () async {
      final userProfileNotifier = ref.read(userProfileNotifierProvider);

      await userProfileNotifier.saveImage(id, File('sample.jpg'));
      expect(userProfileNotifier.debugState.id, id);
      expect(userProfileNotifier.debugState.image, storageFile);

      verify(mockUserProfileImageRepo.save(any, any)).called(1);
    });
    test('プロフィールを取得', () async {
      final userProfileNotifier = ref.read(userProfileNotifierProvider);

      const name = 'mokumoku';
      await userProfileNotifier.loadProfile(id);
      expect(userProfileNotifier.debugState.id, id);
      expect(userProfileNotifier.debugState.name, name);

      verify(mockUserProfileRepo.load(any)).called(1);
    });
  });
}
