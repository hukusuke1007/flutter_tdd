import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';

extension FlutterDriverExtension on FlutterDriver {
  Future<void> waitForExpectText(
    SerializableFinder finder,
    Set<String> expects, {
    Duration timeout = const Duration(milliseconds: 1000),
  }) async {
    final start = DateTime.now();
    // ignore: literal_only_boolean_expressions
    while (true) {
      final now = DateTime.now();
      if (now.millisecondsSinceEpoch >=
          start.millisecondsSinceEpoch + timeout.inMilliseconds) {
        print('timeout');
        break;
      }
      final actual = await getText(finder);
      final result = expects.firstWhere((element) => element == actual,
          orElse: () => null);
      if (result != null) {
        break;
      }
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
}
