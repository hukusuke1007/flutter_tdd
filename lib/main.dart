import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';

Settings getFirestoreEmulatorSetting({int port = 8080}) => Settings(
      persistenceEnabled: false,
      host: '${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:$port',
      sslEnabled: false,
    );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = getFirestoreEmulatorSetting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  // TODO(shohei): 試しロジック
                  final firestore = FirebaseFirestore.instance;
                  final batch = firestore.batch();
                  final ref = firestore.collection('sample').doc();
                  final data = {
                    'name': 'name',
                  };
                  batch
                    ..set(ref, data, SetOptions(merge: true))
                    ..set(ref.collection('secret').doc(), data,
                        SetOptions(merge: true));
                  await batch.commit();
                },
                child: const Text('sample'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
