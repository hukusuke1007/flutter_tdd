import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

ChopperClient chopperClient([http.Client client]) {
  const baseUrl = 'https://api.github.com';
  return ChopperClient(
    baseUrl: baseUrl,
    client: client,
    converter: const JsonConverter(),
  );
}
