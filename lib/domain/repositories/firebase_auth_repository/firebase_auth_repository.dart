import 'dart:async';
import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'credential_result.dart';

abstract class FirebaseAuthRepository {
  Stream<User> get onAuthStateChanged;
  User get authUser;
  String get loggedInUserId;
  bool get isAnonymously;
  bool get isEmailVerification;
  Future<String> get idToken;
  Future<UserCredential> signUpWithEmail(String email, String password);
  Future<UserCredential> linkWithCredential(AuthCredential authCredential);
  Future<void> verifyPhoneNumber(
    String countryCode,
    String phoneNumber, {
    int forceResendingToken,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  });
  Future<void> updatePhoneNumber(PhoneAuthCredential authCredential);
  Future<UserCredential> signInWithAnonymously();
  Future<UserCredential> signInWithEmail(String email, String password);
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithApple();
  Future<UserCredential> signIn(AuthCredential authCredential);
  Future<void> sendEmailVerification();
  Future<void> resetPasswordEmail(String email, String password);
  Future<bool> isPasswordVerified(String email, String password);
  Future<CredentialResult> getCredentialWithGoogle();
  Future<CredentialResult> getCredentialWithApple();
  Future<CredentialResult> getCredentialWithPhoneNumber(
    String code,
    String verificationId,
  );
  Future<void> userDelete(User user);
  Future<void> signOut();
}

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  FirebaseAuthRepositoryImpl(this._auth, this._googleSignIn);

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  @override
  Stream<User> get onAuthStateChanged => _auth.authStateChanges();

  @override
  User get authUser => _auth.currentUser;

  @override
  String get loggedInUserId => _auth.currentUser?.uid;

  @override
  bool get isAnonymously => _auth.currentUser?.isAnonymous;

  @override
  bool get isEmailVerification => _auth.currentUser?.emailVerified;

  @override
  Future<String> get idToken => _auth.currentUser?.getIdToken(true);

  @override
  Future<UserCredential> signUpWithEmail(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential> linkWithCredential(AuthCredential authCredential) =>
      _auth.currentUser.linkWithCredential(authCredential);

  @override
  Future<void> verifyPhoneNumber(
    String countryCode,
    String phoneNumber, {
    int forceResendingToken,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) async {
    final phone = countryCode + phoneNumber;
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      forceResendingToken: forceResendingToken,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<void> updatePhoneNumber(PhoneAuthCredential authCredential) =>
      _auth.currentUser.updatePhoneNumber(authCredential);

  @override
  Future<UserCredential> signInWithAnonymously() => _auth.signInAnonymously();

  @override
  Future<UserCredential> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential> signInWithGoogle() async {
    final signInResult = await getCredentialWithGoogle();
    if (signInResult == null) {
      return null;
    }
    return _auth.signInWithCredential(signInResult.credential);
  }

  @override
  Future<UserCredential> signInWithApple() async {
    if (Platform.isAndroid) {
      return null;
    }
    final signInResult = await getCredentialWithApple();
    if (signInResult == null) {
      return null;
    }
    return _auth.signInWithCredential(signInResult.credential);
  }

  @override
  Future<UserCredential> signIn(AuthCredential authCredential) =>
      _auth.signInWithCredential(authCredential);

  @override
  Future<void> sendEmailVerification() =>
      _auth.currentUser.sendEmailVerification();

  @override
  Future<void> resetPasswordEmail(String email, String password) async {
    await signInWithEmail(email, password);
    return _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<bool> isPasswordVerified(String email, String password) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    final result =
        await _auth.currentUser.reauthenticateWithCredential(credential);
    return result != null;
  }

  @override
  Future<CredentialResult> getCredentialWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final auth = await googleUser.authentication;
    final result = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    return CredentialResult(
      credential: result,
      userId: googleUser.id,
    );
  }

  @override
  Future<CredentialResult> getCredentialWithApple() async {
    final auth = await AppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    switch (auth.status) {
      case AuthorizationStatus.authorized:
        print(auth.credential.user);
        break;
      case AuthorizationStatus.cancelled:
        return null;
        break;
      case AuthorizationStatus.error:
        return null;
        break;
    }
    final oAuthProvider = OAuthProvider('apple.com');
    final result = oAuthProvider.credential(
      idToken: String.fromCharCodes(auth.credential.identityToken),
      accessToken: String.fromCharCodes(auth.credential.authorizationCode),
    );
    return CredentialResult(
      credential: result,
      userId: auth.credential.user,
    );
  }

  @override
  Future<CredentialResult> getCredentialWithPhoneNumber(
    String code,
    String verificationId,
  ) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    ) as PhoneAuthCredential;
    return CredentialResult(
      credential: credential,
      userId: credential.providerId,
    );
  }

  @override
  Future<void> userDelete(User user) => user.delete();

  @override
  Future<void> signOut() => _auth.signOut();
}
