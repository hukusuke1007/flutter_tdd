import 'package:firebase_auth/firebase_auth.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd/domain/index.dart';
import 'package:flutter_tdd/infrastructures/firebaes_auth/firebase_auth_repository_impl.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  String _result = 'Testing...';

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
              Text(_result),
              RaisedButton(
                key: const Key('signInWithAnonymously'),
                padding: const EdgeInsets.all(4),
                color: Colors.lightBlue,
                onPressed: () async {
                  await impl.signInWithAnonymously();
                },
                child: const Text(
                  'signInWithAnonymously',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                key: const Key('signOut'),
                padding: const EdgeInsets.all(4),
                color: Colors.lightBlue,
                onPressed: () async {
                  await impl.signOut();
                },
                child: const Text(
                  'signOut',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                key: const Key('userDelete'),
                padding: const EdgeInsets.all(4),
                color: Colors.lightBlue,
                onPressed: () async {
                  final user = impl.authUser;
                  if (user != null) {
                    await impl.userDelete(user);
                  }
                },
                child: const Text(
                  'userDelete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final Future Function() onTap;

  @override
  _State createState() => _State();
}

class _State extends State<TestWidget> {
  bool _successful;
  Exception _error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          key: widget.key,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              const interactiveStates = <MaterialState>{
                MaterialState.disabled,
              };
              if (states.any(interactiveStates.contains)) {
                return Colors.greenAccent[400];
              }
              return Colors.blue;
            }),
            textStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white),
            ),
          ),
          onPressed: _successful == null
              ? () async {
                  try {
                    await widget.onTap();
                    setState(() {
                      _successful = true;
                    });
                  } on Exception catch (e) {
                    setState(() {
                      _successful = false;
                      _error = e;
                    });
                  }
                }
              : null,
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        _error != null
            ? Text(_error.toString(), style: const TextStyle(color: Colors.red))
            : const SizedBox.shrink(),
      ],
    );
  }
}
