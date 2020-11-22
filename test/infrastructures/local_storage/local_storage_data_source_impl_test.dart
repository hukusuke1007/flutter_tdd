import 'dart:io';

import 'package:flutter_tdd/infrastructures/local_storage/index.dart';
import 'package:test/test.dart';

Future<void> main() async {
  const rooDir = 'test_resource';
  const rootPath = '$rooDir/app';
  final dataSource = LocalStorageDataSourceImpl(rootPath);
  group('LocalStorageDataSourceImpl', () {
    /**
     * 正常系
     */
    const rawFilename = 'sample.jpg';
    const subDir = '0';
    const rawFilePath = '$rooDir/$rawFilename';

    void cleanUp() {
      dataSource
        ..remove(rawFilename)
        ..removeDir(subDir);
    }

    tearDown(cleanUp);

    test('データの保存と取得に成功する', () {
      final file = File(rawFilePath);
      dataSource.save(file, rawFilename);

      expect(dataSource.isExist(rawFilename), true);
      expect(dataSource.load(rawFilename), isNotNull);
    }, retry: 1);

    test('データの保存と取得に成功する（新しいディレクトリを作成）', () {
      final file = File(rawFilePath);
      dataSource.save(file, rawFilename, dirPath: subDir);

      expect(dataSource.isExist(rawFilename, dirPath: subDir), true);
      expect(dataSource.load(rawFilename, dirPath: subDir), isNotNull);
    });

    test('データの削除に成功する', () {
      final file = File(rawFilePath);
      dataSource
        ..save(file, rawFilename)
        ..remove(rawFilename);

      expect(dataSource.isExist(rawFilename), false);
      expect(dataSource.load(rawFilename), isNull);
    });

    test('データの削除に成功する（新しいディレクトリを作成）', () {
      final file = File(rawFilePath);
      dataSource
        ..save(file, rawFilename, dirPath: subDir)
        ..remove(rawFilename, dirPath: subDir);

      expect(dataSource.isExist(rawFilename, dirPath: subDir), false);
      expect(dataSource.load(rawFilename, dirPath: subDir), isNull);
    });
  });
}
