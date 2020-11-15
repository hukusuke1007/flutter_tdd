import 'package:flutter_tdd/infrastructures/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

Future<void> main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  final prefs = await SharedPreferences.getInstance();
  final repo = LocalDatabaseImpl(prefs);
  group('モックを使ったテスト', () {
    const intKey = 'int_key';
    const doubleKey = 'double_key';
    const boolKey = 'bool_key';
    const stringKey = 'string_key';
    const stringListKey = 'string_list_key';

    /**
     * 正常系
     */
    test('データの保存・取得・削除に成功する', () async {
      {
        const value = 100;
        await repo.save<int>(intKey, value);
        expect(await repo.load<int>(intKey), value);
        await repo.remove(intKey);
        expect(await repo.load<int>(intKey), isNull);
      }

      {
        const value = 100.0;
        await repo.save<double>(doubleKey, value);
        expect(await repo.load<double>(doubleKey), value);
        await repo.remove(doubleKey);
        expect(await repo.load<double>(doubleKey), isNull);
      }

      {
        const value = true;
        await repo.save<bool>(boolKey, value);
        expect(await repo.load<bool>(boolKey), value);
        await repo.remove(boolKey);
        expect(await repo.load<bool>(boolKey), isNull);
      }

      {
        const value = 'data';
        await repo.save<String>(stringKey, value);
        final result = await repo.load<String>(stringKey);
        expect(result, value);
        await repo.remove(stringKey);
        expect(await repo.load<String>(stringKey), isNull);
      }
      {
        const value = ['data1', 'data2'];
        await repo.save<List<String>>(stringListKey, value);
        final result = await repo.load<List<String>>(stringListKey);
        expect(result, value);
        await repo.remove(stringListKey);
        expect(await repo.load<List<String>>(stringKey), isNull);
      }
    });
  });
}
