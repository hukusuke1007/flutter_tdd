import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth_mocks/src/mock_user_credential.dart';
import 'package:flutter_tdd/domain/repositories/firebase_auth_repository/firebase_auth_repository.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseAuthRepository Test', () {
    const email = 'mokumoku@moku.com';
    const password = 'password';

    test('[成功] サインアップ（メールアドレスとパスワード）', () async {
      final auth = MockFirebaseAuth();
      final googleSignIn = MockGoogleSignIn();
      when(auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer(
              (_) => Future.value(MockUserCredential(isAnonymous: false)));

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      final result = await impl.signUpWithEmail(email, password);
      expect(result, isNotNull);
      verify(auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .called(1);
    });
    test('[成功] サインアップ（他のCredentialとリンク）', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();
      const credential =
          AuthCredential(providerId: 'dummyId', signInMethod: 'dummyMethod');
      when(auth.currentUser.linkWithCredential(credential)).thenAnswer(
          (_) => Future.value(MockUserCredential(isAnonymous: false)));

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      final result = await impl.linkWithCredential(credential);
      expect(result, isNotNull);
      verify(auth.currentUser.linkWithCredential(credential)).called(1);
    });
  });
}
