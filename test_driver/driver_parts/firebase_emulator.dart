import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void setFirestoreEmulator({int port = 8080}) {
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: false,
    host: '${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:$port',
    sslEnabled: false,
  );
}

void setFirebaseAuthEmulator({int port = 9099}) {
  // TODO(shohei): firebase_authの対応待ち
}
