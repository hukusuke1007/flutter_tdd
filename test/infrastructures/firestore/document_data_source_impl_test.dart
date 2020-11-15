import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('DocumentDataSourceImpl', () {
    const collectionPath = 'collectionPath';
    const data1 = <String, dynamic>{'name': 'name1'};
    const data2 = <String, dynamic>{'name': 'name2'};
    /**
     * 正常系
     */
    test('データの作成・取得・更新・削除に成功する', () async {
      final mock = MockFirestoreInstance();
      final repo = DocumentDataSourceImpl(mock);

      // 作成
      final id = await repo.save(collectionPath, data: data1);

      // 取得
      {
        final snapshot = await repo.load(collectionPath, id);
        expect(snapshot.data()['name'], 'name1');
      }

      // 更新
      {
        await repo.save(collectionPath, id: id, data: data2);
        final snapshot = await repo.load(collectionPath, id);
        expect(snapshot.data()['name'], 'name2');
      }

      // 削除
      {
        await repo.remove(collectionPath, id);
        final snapshot = await repo.load(collectionPath, id);
        expect(snapshot.exists, false);
      }
    });
  });
}
