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

    test('[成功] プレイヤーを削除する', () async {
      final btn = find.byValueKey('delete');
      final result = find.byValueKey('deleteResult');
      await driver.tap(btn);
      await driver.waitForExpectText(result, resultTexts,
          timeout: timeout); // ラベルが変わるまで待つ
      expect(await driver.getText(result), resultTexts.first);
    });

    test('[成功] プレイヤーの一括作成・取得する', () async {
      final btn = find.byValueKey('batchCreateRead');
      final result = find.byValueKey('batchCreateReadResult');
      await driver.tap(btn);
      await driver.waitForExpectText(result, resultTexts,
          timeout: timeout); // ラベルが変わるまで待つ
      expect(await driver.getText(result), resultTexts.first);
    });
  });
}
