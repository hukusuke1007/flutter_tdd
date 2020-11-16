import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tdd/infrastructures/firebaes_auth/credential_result.dart';
import 'package:flutter_tdd/infrastructures/firebaes_auth/firebase_auth_repository_impl.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/all.dart';

final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>((_) {
  return FirebaseAuthRepositoryImpl(
      FirebaseAuth.instance, GoogleSignIn(scopes: ['email']));
});

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
  CredentialResult getCredentialWithPhoneNumber(
    String code,
    String verificationId,
  );
  Future<void> userDelete(User user);
  Future<void> signOut();
}
