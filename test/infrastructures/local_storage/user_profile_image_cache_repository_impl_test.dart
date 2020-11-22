import 'dart:io';

import 'package:flutter_tdd/infrastructures/local_storage/index.dart';
import 'package:test/test.dart';

Future<void> main() async {
  const rooDir = 'test_resource';
  const rootPath = '$rooDir/app';
  final dataSource = LocalStorageDataSourceImpl(rootPath);
  final repo = UserProfileImageCacheRepositoryImpl(dataSource);
  group('UserProfileImageCacheRepositoryImpl', () {
    /**
     * 正常系
     */
    const rawFilename = 'sample.jpg';
    const rawFilePath = '$rooDir/$rawFilename';

    void cleanUp() {
      dataSource.remove(rawFilename);
    }

    tearDown(cleanUp);

    test('画像の保存と取得に成功する', () {
      final file = File(rawFilePath);
      repo.save(file);

      expect(repo.isExist(), true);
      expect(repo.load(), isNotNull);
    });

    test('画像の削除に成功する', () {
      final file = File(rawFilePath);
      repo
        ..save(file)
        ..delete();

      expect(repo.isExist(), false);
      expect(repo.load(), isNull);
    });
  });
}
