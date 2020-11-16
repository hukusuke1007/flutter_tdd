import 'dart:io';

import 'package:flutter_tdd/infrastructures/firebase_storage/firebase_storage_data_source.dart';
import 'package:test/test.dart';

import 'mock/index.dart';

Future<void> main() async {
  group('DocumentDataSourceImpl', () {
    /**
     * 正常系
     */
    test('[成功] 画像を保存する', () async {
      final storage = MockFirebaseStorage();
      final repo = FirebaseStorageDataSourceImpl(storage);

      const filename = 'sample.jpg';
      final image = File(filename);
      const dirPath = 'user';
      final url = await repo.save(image, dirPath: dirPath);
      expect(url, isNotNull);
    });
    test('[成功] 画像を取得する', () async {
      final storage = MockFirebaseStorage();
      final repo = FirebaseStorageDataSourceImpl(storage);

      const filename = 'sample.jpg';
      final image = File(filename);
      const dirPath = 'user';
      final url1 = await repo.save(image, dirPath: dirPath, filename: filename);
      expect(url1, isNotNull);
      final url2 = await repo.gerDownloadUrl(dirPath, filename);
      expect(url2, isNotNull);
      expect(url1, url2);
    });
    test('[成功] 画像を削除する', () async {
      final storage = MockFirebaseStorage();
      final repo = FirebaseStorageDataSourceImpl(storage);

      const filename = 'sample.jpg';
      final image = File(filename);
      const dirPath = 'user';
      final url1 = await repo.save(image, dirPath: dirPath, filename: filename);
      expect(url1, isNotNull);
      await repo.delete(dirPath, filename);
      final url2 = await repo.gerDownloadUrl(dirPath, filename);
      expect(url2, isNull);
    });
  });
}
