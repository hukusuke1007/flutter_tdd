import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../driver_parts/flutter_driver_extension.dart';

void main() {
  group('FirebaseAuthRepositoryImpl', () {
    const timeout = Duration(seconds: 5);
    const resultTexts = {'OK', 'NG'};
    final userDeleteBtn = find.byValueKey('userDelete');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.tap(userDeleteBtn);
      if (driver != null) {
        await driver.close();
      }
    });

    test('[成功] サインイン（匿名認証）', () async {
      final btn = find.byValueKey('signInWithAnonymously');
      final result = find.byValueKey('signInWithAnonymouslyResult');
      await driver.tap(btn);
      await driver.waitForExpectText(result, resultTexts,
          timeout: timeout); // ラベルが変わるまで待つ
      expect(await driver.getText(result), resultTexts.first);
    });

    test('[成功] サインアウト', () async {
      final btn = find.byValueKey('signOut');
      final result = find.byValueKey('signOutResult');
      await driver.tap(btn);
      expect(await driver.getText(result), resultTexts.first);
    });
  });
}
