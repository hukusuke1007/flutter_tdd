import 'package:flutter_tdd/infrastructures/index.dart';
import 'package:flutter_tdd/infrastructures/local_database/local_database_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

Future<void> main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  final prefs = await SharedPreferences.getInstance();
  final impl = LocalDatabaseRepositoryImpl(LocalDatabaseImpl(prefs));

  group('LocalDatabaseRepository Test', () {
    test('データの保存・取得に成功する', () async {
      const value = 'もくもくさん';
      await impl.saveName(value);
      expect(await impl.loadName(), value);
    });
  });
}
