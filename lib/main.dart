import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd/domain/repositories/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/player_repository_impl.dart';

void _assertPlayer(Player actual, Player data) {
  assert(actual.id != null, 'id is null');
  assert(actual.name == data.name, ' name is difference.');
  assert(actual.createdAt != null, 'createdAt is null');
  assert(actual.updatedAt != null, 'updatedAt is null');
}

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
      home: const MyHomePage(title: 'PlayerRepositoryImpl'),
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
  PlayerRepository get repo {
    final firestore = FirebaseFirestore.instance;
    return PlayerRepositoryImpl(
      DocumentDataSourceImpl(firestore),
      firestore,
    );
  }

  String _id;

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
                title: '[成功] プレイヤーの作成・取得・更新する',
                key: const Key('createReadUpdate'),
                resultKey: const Key('createReadUpdateResult'),
                onTapTestCase: () async {
                  // 作成
                  {
                    final player = Player(name: 'name');
                    _id = await repo.save(player);
                    final result = await repo.load(_id);
                    _assertPlayer(result, player);
                  }

                  // 更新
                  {
                    await repo.save(Player(name: 'name1'));
                    final player = Player(name: 'name2');
                    await repo.update(_id, player);
                    final result = await repo.load(_id);
                    _assertPlayer(result, player);
                  }
                },
              ),
              TestWidget(
                title: '[成功] プレイヤーを削除する',
                key: const Key('delete'),
                resultKey: const Key('deleteResult'),
                onTapTestCase: () async {
                  if (_id != null) {
                    final id = _id;
                    await repo.remove(id);
                    final result = await repo.load(id);
                    assert(result == null, 'result is null');
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

class TestWidget extends StatefulWidget {
  const TestWidget({
    @required Key key,
    @required this.resultKey,
    @required this.title,
    @required this.onTapTestCase,
  }) : super(key: key);

  final String title;
  final Key resultKey;
  final Future Function() onTapTestCase;

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
                    await widget.onTapTestCase();
                    setState(() {
                      _successful = true;
                    });
                  } on Exception catch (e) {
                    setState(() {
                      _successful = false;
                      _error = e;
                    });
                  }
                  await Future<void>.delayed(
                      const Duration(milliseconds: 3000));
                }
              : null,
          child: Text(
            _successful == null
                ? widget.title
                : _successful == true
                    ? 'OK'
                    : 'NG',
            key: widget.resultKey,
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
