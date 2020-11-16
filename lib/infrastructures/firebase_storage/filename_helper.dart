import 'dart:math';

class FilenameHelper {
  FilenameHelper._();
  static String randomString({int length}) {
    const _randomChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const _charsLength = _randomChars.length;
    final rand = Random();
    final codeUnits = List.generate(
      length ?? 10,
      (index) {
        final n = rand.nextInt(_charsLength);
        return _randomChars.codeUnitAt(n);
      },
    );
    return String.fromCharCodes(codeUnits);
  }
}
