import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/player_repository_impl.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('PlayerRepositoryImpl', () {
    void _assertPlayer(Player actual, Player data) {
      expect(actual.id, isNotNull);
      expect(actual.name, data.name);
      expect(actual.createdAt, isNotNull);
      expect(actual.updatedAt, isNotNull);
    }

    /**
     * 正常系
     */
    test('[成功] プレイヤーの作成・取得・更新する', () async {
      final mock = MockFirestoreInstance();
      final dataSource = DocumentDataSourceImpl(mock);
      final repo = PlayerRepositoryImpl(dataSource, mock);

      // 作成
      {
        final player = Player(name: 'name');
        final id = await repo.save(player);
        final result = await repo.load(id);
        _assertPlayer(result, player);
      }

      // 更新
      {
        final id = await repo.save(Player(name: 'name1'));
        final player = Player(name: 'name2');
        await repo.update(id, player);
        final result = await repo.load(id);
        _assertPlayer(result, player);
      }
    });

    test('[成功] プレイヤーを削除する', () async {
      final mock = MockFirestoreInstance();
      final dataSource = DocumentDataSourceImpl(mock);
      final repo = PlayerRepositoryImpl(dataSource, mock);

      final id = await repo.save(Player(name: 'name'));
      await repo.remove(id);
      final result = await repo.load(id);
      expect(result, isNull);
    });

    test('[成功] プレイヤーの一括作成・取得する', () async {
      final mock = MockFirestoreInstance();
      final dataSource = DocumentDataSourceImpl(mock);
      final repo = PlayerRepositoryImpl(dataSource, mock);

      final data = [
        Player(name: 'name1'),
        Player(name: 'name2'),
        Player(name: 'name3'),
        Player(name: 'name4'),
        Player(name: 'name5'),
        Player(name: 'name6')
      ];
      await repo.saveAll(data);
      final result = await repo.loadAll(limit: 3, desc: false);
      expect(result.length, 3);
      for (var i = 0; i < result.length; i++) {
        _assertPlayer(result[i], data[i]);
      }
    });
  });
}
