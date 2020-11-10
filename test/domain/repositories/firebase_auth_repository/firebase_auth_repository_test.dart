import 'package:flutter_tdd/domain/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:test/test.dart';

import 'firebase_auth_mock.dart';

void main() {
  group('FirebaseAuthRepository Test', () {
    const email = 'mokumoku@moku.com';
    const password = 'password';

    test('[成功] サインアップ（メールアドレスとパスワード）', () async {
      final auth = MockFirebaseAuthExtend();
      final googleSignIn = MockGoogleSignIn();
      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);

      final result = await impl.signUpWithEmail(email, password);
      expect(result, isNotNull);
    });
  });
}
