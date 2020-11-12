import 'package:flutter_tdd/domain/repositories/github_repository.dart';

import 'index.dart';

class GithubRepositoryImpl implements GithubRepository {
  GithubRepositoryImpl(this._githubClient);

  final GithubClient _githubClient;

  @override
  Future<List<User>> fetchUsers() async {
    final response = await _githubClient.fetchUsers();
    if (response.isSuccessful) {
      final responseBodyJson = response.body as List<dynamic>;
      return responseBodyJson
          .map((dynamic e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response.error);
    }
  }
}
