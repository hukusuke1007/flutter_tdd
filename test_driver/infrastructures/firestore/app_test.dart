import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../driver_parts/flutter_driver_extension.dart';

void main() {
  group('PlayerRepositoryImpl', () {
    const timeout = Duration(seconds: 5);
    const resultTexts = {'OK', 'NG'};
    final userDeleteBtn = find.byValueKey('delete');

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

    /**
     * 正常系
     */
    test('[成功] プレイヤーの作成・取得・更新する', () async {
      final btn = find.byValueKey('createReadUpdate');
      final result = find.byValueKey('createReadUpdateResult');
      await driver.tap(btn);
      await driver.waitForExpectText(result, resultTexts,
          timeout: timeout); // ラベルが変わるまで待つ
      expect(await driver.getText(result), resultTexts.first);
    });
  });
}
