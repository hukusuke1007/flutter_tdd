import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth_mocks/src/mock_user_credential.dart';
import 'package:flutter/foundation.dart';

class MockFirebaseAuthExtend extends MockFirebaseAuth {
  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);
    return MockUserCredential(isAnonymous: false);
  }
}
