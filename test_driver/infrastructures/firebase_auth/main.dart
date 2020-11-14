import 'package:firebase_auth/firebase_auth.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd/domain/index.dart';
import 'package:flutter_tdd/infrastructures/firebaes_auth/firebase_auth_repository_impl.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../driver_parts/test_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flamingo.initializeApp();
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
      home: const MyHomePage(title: 'FirebaseAuthRepositoryImpl'),
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
  final FirebaseAuthRepository impl = FirebaseAuthRepositoryImpl(
    FirebaseAuth.instance,
    GoogleSignIn(scopes: ['email']),
  );

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
              TestWidget(
                title: '[成功] サインイン（匿名認証）',
                key: const Key('signInWithAnonymously'),
                resultKey: const Key('signInWithAnonymouslyResult'),
                onTapTestCase: () async {
                  await impl.signInWithAnonymously();
                },
              ),
              TestWidget(
                title: '[成功] サインアウト',
                key: const Key('signOut'),
                resultKey: const Key('signOutResult'),
                onTapTestCase: () async {
                  await impl.signOut();
                },
              ),
              TestWidget(
                title: '[成功] ユーザー削除',
                key: const Key('userDelete'),
                resultKey: const Key('userDeleteResult'),
                onTapTestCase: () async {
                  final user = impl.authUser;
                  if (user != null) {
                    await impl.userDelete(user);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
