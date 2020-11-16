import 'dart:io';

import 'package:flutter_tdd/infrastructures/firebase_storage/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';
import 'package:test/test.dart';

import 'mock/index.dart';

Future<void> main() async {
  group('UserProfileRepositoryImpl', () {
    /**
     * 正常系
     */
    test('[成功] 画像を保存する', () async {
      final storage = MockFirebaseStorage();
      final dataSource = FirebaseStorageDataSourceImpl(storage);
      final repo = UserProfileRepositoryImpl(dataSource);

      const filename = 'sample.jpg';
      final image = File(filename);
      const userId = 'user0';
      final storageFile = await repo.save(image, userId);
      expect(storageFile.url, isNotNull);
      expect(storageFile.path,
          '${UserProfile.collectionPath}/$userId/${UserProfile.imageFilename}');
      expect(storageFile.mimeType, isNotNull);
      expect(storageFile.metadata, isNull);
    });

    test('[成功] 画像を削除する', () async {
      final storage = MockFirebaseStorage();
      final dataSource = FirebaseStorageDataSourceImpl(storage);
      final repo = UserProfileRepositoryImpl(dataSource);

      const filename = 'sample.jpg';
      final image = File(filename);
      const userId = 'user0';
      await repo.save(image, userId);
      await repo.delete(userId);
    });
  });
}
