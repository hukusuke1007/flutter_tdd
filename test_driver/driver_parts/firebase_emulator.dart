import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

Settings getFirestoreEmulatorSetting({int port = 8080}) => Settings(
      persistenceEnabled: false,
      host: '${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:$port',
      sslEnabled: false,
    );
