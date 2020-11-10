import 'package:flutter_tdd/domain/repositories/github_repository/github_repository.dart';
import 'package:flutter_tdd/infrastructures/github/github_client.dart';
import 'package:flutter_tdd/infrastructures/github/github_client_creator.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('GithubRepository Test', () {
    group('サーバーと疎通したテスト', () {
      final impl = GithubRepositoryImpl(GithubClient.create(chopperClient));
      test('[成功] ユーザー情報を取得する', () async {
        final result = await impl.fetchUsers();
        expect(true, result.isNotEmpty);
      });
    });
    group('モックを使ったテスト', () {
      // TODO(shohei):
    });
  });
}
