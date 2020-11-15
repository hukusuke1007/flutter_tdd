import 'package:flutter_tdd/infrastructures/github/index.dart';
import 'package:test/test.dart';

void main() {
  group('サーバーと疎通したテスト', () {
    final repo = GithubRepositoryImpl(GithubClient.create(chopperClient()));

    /**
     * 正常系
     */
    test('[成功] ユーザー情報を取得する', () async {
      final result = await repo.fetchUsers();
      expect(result.isNotEmpty, true);
    }, skip: true);
  });
}
