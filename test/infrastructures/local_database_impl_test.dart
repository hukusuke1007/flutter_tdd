import 'package:flutter_tdd/infrastructures/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

Future<void> main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  final prefs = await SharedPreferences.getInstance();
  final impl = LocalDatabaseImpl(prefs);
  group('モックを使ったテスト', () {
    const intKey = 'int_key';
    const doubleKey = 'double_key';
    const boolKey = 'bool_key';
    const stringKey = 'string_key';
    const stringListKey = 'string_list_key';

    test('データの保存・取得・削除に成功する', () async {
      {
        const value = 100;
        await impl.save<int>(intKey, value);
        expect(await impl.load<int>(intKey), value);
        await impl.remove(intKey);
        expect(await impl.load<int>(intKey), isNull);
      }

      {
        const value = 100.0;
        await impl.save<double>(doubleKey, value);
        expect(await impl.load<double>(doubleKey), value);
        await impl.remove(doubleKey);
        expect(await impl.load<double>(doubleKey), isNull);
      }

      {
        const value = true;
        await impl.save<bool>(boolKey, value);
        expect(await impl.load<bool>(boolKey), value);
        await impl.remove(boolKey);
        expect(await impl.load<bool>(boolKey), isNull);
      }

      {
        const value = 'data';
        await impl.save<String>(stringKey, value);
        final result = await impl.load<String>(stringKey);
        expect(result, value);
        await impl.remove(stringKey);
        expect(await impl.load<String>(stringKey), isNull);
      }
      {
        const value = ['data1', 'data2'];
        await impl.save<List<String>>(stringListKey, value);
        final result = await impl.load<List<String>>(stringListKey);
        expect(result, value);
        await impl.remove(stringListKey);
        expect(await impl.load<List<String>>(stringKey), isNull);
      }
    });
  });
}
