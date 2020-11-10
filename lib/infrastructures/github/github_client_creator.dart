import 'package:chopper/chopper.dart';

ChopperClient get chopperClient {
  const baseUrl = 'https://api.github.com';
  return ChopperClient(
    baseUrl: baseUrl,
    converter: const JsonConverter(),
  );
}
