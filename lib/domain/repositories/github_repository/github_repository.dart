import '../../../infrastructures/github/index.dart';
import 'entities/user/user.dart';

// ignore: one_member_abstracts
abstract class GithubRepository {
  Future<List<User>> fetchUsers();
}

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
