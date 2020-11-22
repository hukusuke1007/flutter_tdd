import 'package:flutter_tdd/infrastructures/local_database/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

Future<void> main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  final prefs = await SharedPreferences.getInstance();
  final dataSource = LocalDatabaseDataSourceImpl(prefs);
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
        await dataSource.save<int>(intKey, value);
        expect(await dataSource.load<int>(intKey), value);
        await dataSource.remove(intKey);
        expect(await dataSource.load<int>(intKey), isNull);
      }

      {
        const value = 100.0;
        await dataSource.save<double>(doubleKey, value);
        expect(await dataSource.load<double>(doubleKey), value);
        await dataSource.remove(doubleKey);
        expect(await dataSource.load<double>(doubleKey), isNull);
      }

      {
        const value = true;
        await dataSource.save<bool>(boolKey, value);
        expect(await dataSource.load<bool>(boolKey), value);
        await dataSource.remove(boolKey);
        expect(await dataSource.load<bool>(boolKey), isNull);
      }

      {
        const value = 'data';
        await dataSource.save<String>(stringKey, value);
        final result = await dataSource.load<String>(stringKey);
        expect(result, value);
        await dataSource.remove(stringKey);
        expect(await dataSource.load<String>(stringKey), isNull);
      }
      {
        const value = ['data1', 'data2'];
        await dataSource.save<List<String>>(stringListKey, value);
        final result = await dataSource.load<List<String>>(stringListKey);
        expect(result, value);
        await dataSource.remove(stringListKey);
        expect(await dataSource.load<List<String>>(stringKey), isNull);
      }
    });
  });
}
