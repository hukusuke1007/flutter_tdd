import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth_mocks/src/mock_user_credential.dart';
import 'package:flutter_tdd/domain/repositories/firebase_auth_repository/firebase_auth_repository.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockAuth extends Mock implements FirebaseAuth {}

void main() {
  group('モックを使ったテスト', () {
    const email = 'mokumoku@moku.com';
    const password = 'password';
    const mockUid = 'aabbcc';

    /**
     * 正常系テスト
     */
    test('[成功] ユーザー情報を取得する', () async {
      const isEmailVerified = true;
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();

      when(auth.currentUser.emailVerified).thenReturn(isEmailVerified);

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);

      expect(impl.loggedInUserId, auth.currentUser.uid);
      expect(impl.isAnonymously, auth.currentUser.isAnonymous);
      expect(impl.isEmailVerification, isEmailVerified);
      expect(await impl.idToken, await auth.currentUser.getIdToken());

      verify(auth.currentUser.emailVerified).called(1);
    });

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

    test('[成功] 国コードと電話番号で認証する', () async {
      const countryCode = '+81';
      const phoneNumber = '09000000000';
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();
      when(auth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber,
        forceResendingToken: null,
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: null,
        codeAutoRetrievalTimeout: null,
      )).thenAnswer((_) => Future<void>.value());

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      await impl.verifyPhoneNumber(countryCode, phoneNumber);
      verify(await auth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber,
        forceResendingToken: null,
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: null,
        codeAutoRetrievalTimeout: null,
        timeout: const Duration(seconds: 60),
      ))
          .called(1);
    });

    test('[成功] SMSコードでログインする', () async {
      const code = '000000';
      const verificationId = 'verificationId';
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      final result = impl.getCredentialWithPhoneNumber(code, verificationId);
      await impl.updatePhoneNumber(result.credential as PhoneAuthCredential);
      expect(result.credential, isNotNull);
      expect(result.providerId, 'phone');
    });

    test('[成功] サインイン（匿名認証）', () async {
      final auth = MockFirebaseAuth();
      final googleSignIn = MockGoogleSignIn();

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      final result = await impl.signInWithAnonymously();
      expect(result.user.uid, mockUid);
      expect(result.user.isAnonymous, true);
    });

    test('[成功] サインイン（メールアドレスとパスワード）', () async {
      final auth = MockFirebaseAuth();
      final googleSignIn = MockGoogleSignIn();

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      final result = await impl.signInWithEmail(email, password);
      expect(result.user.uid, mockUid);
      expect(result.user.isAnonymous, false);
    });

    test('[成功] サインイン（authCredential）', () async {
      final auth = MockFirebaseAuth();
      final googleSignIn = MockGoogleSignIn();

      const code = '000000';
      const verificationId = 'verificationId';

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      final credentialResult =
          impl.getCredentialWithPhoneNumber(code, verificationId);
      final userCredential = await impl.signIn(credentialResult.credential);
      expect(userCredential.user.uid, mockUid);
    });

    test('[成功] 本人確認メールの送信', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();
      when(auth.currentUser.sendEmailVerification())
          .thenAnswer((_) => Future.value());

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      await impl.sendEmailVerification();
      verify(auth.currentUser.sendEmailVerification()).called(1);
    });

    test('[成功] パスワードリセットメールの送信', () async {
      final auth = MockAuth();
      final googleSignIn = MockGoogleSignIn();
      when(auth.signInWithEmailAndPassword(email: email, password: password))
          .thenAnswer(
              (_) => Future.value(MockUserCredential(isAnonymous: false)));
      when(auth.sendPasswordResetEmail(email: email))
          .thenAnswer((_) => Future.value());

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      await impl.resetPasswordEmail(email, password);
      verify(auth.signInWithEmailAndPassword(email: email, password: password))
          .called(1);
      verify(auth.sendPasswordResetEmail(email: email)).called(1);
    });

    test('[成功] パスワードが正しいか検証する', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();
      when(auth.currentUser.reauthenticateWithCredential(any)).thenAnswer(
          (_) => Future.value(MockUserCredential(isAnonymous: false)));

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      await impl.isPasswordVerified(email, password);
      verify(auth.currentUser.reauthenticateWithCredential(any)).called(1);
    });

    test('[成功] 認証ユーザーを削除する', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();
      when(auth.currentUser.delete()).thenAnswer((_) => Future.value());

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      await impl.userDelete(auth.currentUser);
      verify(auth.currentUser.delete()).called(1);
    });

    test('[成功] サインアウトする', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      final googleSignIn = MockGoogleSignIn();

      final impl = FirebaseAuthRepositoryImpl(auth, googleSignIn);
      await impl.signOut();
      expect(auth.currentUser, isNull);
    });

    /**
     * TODO(shohei): 次のテストはProviderがstaticなためモックかできないのでテストできない
     * signInWithGoogle();
     * getCredentialWithGoogle();
     * signInWithApple();
     * getCredentialWithApple();
     */

    // TODO(shohei): 異常系テスト
  });
}
