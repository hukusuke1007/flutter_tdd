// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_client.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GithubClient extends GithubClient {
  _$GithubClient([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GithubClient;

  @override
  Future<Response<dynamic>> fetchUsers() {
    final $url = '/users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
