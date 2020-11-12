import 'package:flutter_tdd/infrastructures/github/entities/index.dart';

// ignore: one_member_abstracts
abstract class GithubRepository {
  Future<List<User>> fetchUsers();
}
