import 'dart:convert';

import 'package:flutter_tdd/infrastructures/github/index.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'mock_data.dart';

void main() {
  group('モックを使ったテスト', () {
    /**
     * 正常系
     */
    test('[成功] ユーザー情報を取得する', () async {
      // 参考: https://hadrien-lejard.gitbook.io/chopper/faq#mock-chopperclient-for-testing
      final mock = MockClient((request) async {
        final result = mockUsersData[request.url.path] as List<dynamic>;
        if (result == null) {
          return http.Response(json.encode({'error': 'not found'}), 404);
        }
        return http.Response(json.encode(result), 200);
      });
      final impl =
          GithubRepositoryImpl(GithubClient.create(chopperClient(mock)));
      final result = await impl.fetchUsers();
      expect(result.isNotEmpty, true);
    });

    /**
     * 異常系
     */
    test('[失敗] ユーザー情報を取得する', () async {
      final mock = MockClient((request) async {
        return http.Response(json.encode({'error': 'server error'}), 400);
      });
      try {
        final repo =
            GithubRepositoryImpl(GithubClient.create(chopperClient(mock)));
        await repo.fetchUsers();
        fail('failed test');
      } on Exception catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
