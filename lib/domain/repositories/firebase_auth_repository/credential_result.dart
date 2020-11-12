import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CredentialResult {
  CredentialResult({
    @required this.credential,
    @required this.providerId,
  });
  AuthCredential credential;
  String providerId;
}
