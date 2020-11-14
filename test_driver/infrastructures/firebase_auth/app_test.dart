import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseAuthRepositoryImpl', () {
    final signInWithAnonymouslyBtn = find.byValueKey('signInWithAnonymously');
    final signOutBtn = find.byValueKey('signOut');
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
      await driver.tap(signInWithAnonymouslyBtn);
    });
  });
}
