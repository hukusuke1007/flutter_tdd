import 'package:flutter_tdd/infrastructures/github/entities/index.dart';
import 'package:flutter_tdd/infrastructures/github/github_client.dart';
import 'package:flutter_tdd/infrastructures/github/github_client_creator.dart';
import 'package:flutter_tdd/infrastructures/github/github_repository_impl.dart';
import 'package:hooks_riverpod/all.dart';

final githubRepositoryProvider = Provider<GithubRepository>((_) {
  return GithubRepositoryImpl(GithubClient.create(chopperClient()));
});

// ignore: one_member_abstracts
abstract class GithubRepository {
  Future<List<User>> fetchUsers();
}
