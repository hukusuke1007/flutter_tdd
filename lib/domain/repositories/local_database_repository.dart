import 'package:flutter_tdd/infrastructures/local_database/index.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localDatabaseRepositoryProvider =
    FutureProvider<LocalDatabaseRepository>((_) async {
  final pref = await SharedPreferences.getInstance();
  final dataSource = LocalDatabaseImpl(pref);
  return LocalDatabaseRepositoryImpl(dataSource);
});

abstract class LocalDatabaseRepository {
  Future<void> saveName(String value);
  Future<String> loadName();
}
