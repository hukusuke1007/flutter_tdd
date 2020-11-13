import 'package:flutter_tdd/infrastructures/github/index.dart';
import 'package:test/test.dart';

void main() {
  group('サーバーと疎通したテスト', () {
    final impl = GithubRepositoryImpl(GithubClient.create(chopperClient()));
    test('[成功] ユーザー情報を取得する', () async {
      final result = await impl.fetchUsers();
      expect(result.isNotEmpty, true);
    }, skip: true);
  });
}
