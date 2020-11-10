import 'package:flutter_tdd/infrastructures/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

Future<void> main() async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{});
  final prefs = await SharedPreferences.getInstance();
  final impl = LocalDatabaseImpl(prefs);

  group('LocalDatabase Test', () {
    const intKey = 'int_key';
    const doubleKey = 'double_key';
    const boolKey = 'bool_key';
    const stringKey = 'string_key';
    const stringListKey = 'string_list_key';

    setUpAll(() async {
      print('before All');
    });

    tearDownAll(() async {
      print('after All');
    });

    test('データの保存・取得・削除に成功する', () async {
      {
        const value = 100;
        await impl.save<int>(intKey, value);
        expect(value, await impl.load<int>(intKey));
        await impl.remove(intKey);
        expect(null, await impl.load<int>(intKey));
      }

      {
        const value = 100.0;
        await impl.save<double>(doubleKey, value);
        expect(value, await impl.load<double>(doubleKey));
        await impl.remove(doubleKey);
        expect(null, await impl.load<double>(doubleKey));
      }

      {
        const value = true;
        await impl.save<bool>(boolKey, value);
        expect(value, await impl.load<bool>(boolKey));
        await impl.remove(boolKey);
        expect(null, await impl.load<bool>(boolKey));
      }

      {
        const value = 'data';
        await impl.save<String>(stringKey, value);
        final result = await impl.load<String>(stringKey);
        expect(value, result);
        await impl.remove(stringKey);
        expect(null, await impl.load<String>(stringKey));
      }
      {
        const value = ['data1', 'data2'];
        await impl.save<List<String>>(stringListKey, value);
        final result = await impl.load<List<String>>(stringListKey);
        expect(value, result);
        await impl.remove(stringListKey);
        expect(null, await impl.load<List<String>>(stringKey));
      }
    });
  });
}
