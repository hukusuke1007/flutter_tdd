import 'package:chopper/chopper.dart';

part 'github_client.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class GithubClient extends ChopperService {
  static GithubClient create([ChopperClient client]) => _$GithubClient(client);

  @Get(path: 'users')
  Future<Response> fetchUsers();
}
