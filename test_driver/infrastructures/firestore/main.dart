import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd/domain/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/player_repository_impl.dart';

import '../../driver_parts/test_widget.dart';

void _assertPlayer(Player actual, Player data) {
  assert(actual.id != null, 'id is null');
  assert(actual.name == data.name, ' name is difference.');
  assert(actual.createdAt != null, 'createdAt is null');
  assert(actual.updatedAt != null, 'updatedAt is null');
}

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
                  final player = Player(name: 'name1');
                  final id = await repo.save(player);
                  final result = await repo.load(id);
                  _assertPlayer(result, player);

                  // 更新
                  {
                    final player = Player(name: 'name2');
                    await repo.update(id, player);
                    final result = await repo.load(id);
                    _assertPlayer(result, player);
                  }
                },
              ),
              TestWidget(
                title: '[成功] プレイヤーを削除する',
                key: const Key('delete'),
                resultKey: const Key('deleteResult'),
                onTapTestCase: () async {
                  final id = await repo.save(Player(name: 'name'));
                  await repo.remove(id);
                  final result = await repo.load(id);
                  assert(result == null, 'result is null');
                },
              ),
              TestWidget(
                title: '[成功] プレイヤーの一括作成・取得する',
                key: const Key('batchCreateRead'),
                resultKey: const Key('batchCreateReadResult'),
                onTapTestCase: () async {
                  final data = [
                    Player(name: 'name1'),
                    Player(name: 'name2'),
                    Player(name: 'name3'),
                  ];
                  final limit = data.length;
                  await repo.saveAll(data);
                  final result = await repo.loadAll(limit: limit, desc: false);
                  assert(result.length == limit, 'length is ${result.length}');
                  for (final data in result) {
                    final player = await repo.load(data.id);
                    _assertPlayer(player, data);
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
