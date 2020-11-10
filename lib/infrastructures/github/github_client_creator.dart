import 'package:chopper/chopper.dart';

// ignore: avoid_classes_with_only_static_members
class GithubClientCreator {
  static String baseUrl = 'https://api.github.com';

  static ChopperClient create() {
    return ChopperClient(
      baseUrl: GithubClientCreator.baseUrl,
      converter: const JsonConverter(),
    );
  }
}
