import 'package:flutter_tdd/infrastructures/local_database/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

Future<void> main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  final prefs = await SharedPreferences.getInstance();
  final repo = LocalDatabaseRepositoryImpl(LocalDatabaseImpl(prefs));

  group('LocalDatabaseRepository Test', () {
    /**
     * 正常系
     */
    test('データの保存・取得に成功する', () async {
      const value = 'もくもくさん';
      await repo.saveName(value);
      expect(await repo.loadName(), value);
    });
  });
}
