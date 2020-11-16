import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';
import 'package:flutter_tdd/infrastructures/firestore/user_profile_repository_impl.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('UserProfileRepositoryImpl', () {
    void _assertUserProfile(UserProfile actual, UserProfile data) {
      expect(actual.id, isNotNull);
      expect(actual.name, data.name);
      expect(actual.image, isNull);
      expect(actual.createdAt, isNotNull);
      expect(actual.updatedAt, isNotNull);
    }

    /**
     * 正常系
     */
    test('[成功] ユーザーの作成・取得・更新する', () async {
      final mock = MockFirestoreInstance();
      final dataSource = DocumentDataSourceImpl(mock);
      final repo = UserProfileRepositoryImpl(dataSource);

      // 作成
      {
        final data = UserProfile(name: 'name');
        final id = await repo.save(data);
        final result = await repo.load(id);
        _assertUserProfile(result, data);
      }

      // 更新
      {
        final id = await repo.save(UserProfile(name: 'name1'));
        final data = UserProfile(name: 'name2');
        await repo.update(id, data);
        final result = await repo.load(id);
        _assertUserProfile(result, data);
      }
    });
  });
}
