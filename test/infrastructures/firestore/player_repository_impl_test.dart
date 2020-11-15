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
    test('[成功] 作成・取得・更新・削除に成功する', () async {
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
  });
}
