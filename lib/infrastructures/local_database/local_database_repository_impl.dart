import 'package:flutter_tdd/domain/repositories/local_database_repository.dart';

import 'index.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  LocalDatabaseRepositoryImpl(this._localDatabase);
  final LocalDatabase _localDatabase;

  @override
  Future<void> saveName(String value) =>
      _localDatabase.save(LocalDatabaseKey.name.rawValue, value);

  @override
  Future<String> loadName() =>
      _localDatabase.load(LocalDatabaseKey.name.rawValue);
}
