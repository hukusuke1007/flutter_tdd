import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseAuthRepositoryImpl', () {
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
      // TODO(shohei): ここでresultがOKかNGのどちらかを返すまで待つ
      // driver.waitForCondition(, timeout: const Duration(seconds: 10));
      expect(await driver.getText(result), 'OK');
    });

    test('[成功] サインアウト', () async {
      final btn = find.byValueKey('signOut');
      final result = find.byValueKey('signOutResult');
      await driver.tap(btn);
      expect(await driver.getText(result), 'OK');
    });
  });
}
