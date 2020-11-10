import 'package:test/test.dart';

void main() {
  group('Sample Test', () {
    setUpAll(() async {
      print('before All');
    });

    tearDownAll(() async {
      print('after All');
    });

    test('Plus test', () {
      expect(2, 1 + 1);
    });
  });
}
