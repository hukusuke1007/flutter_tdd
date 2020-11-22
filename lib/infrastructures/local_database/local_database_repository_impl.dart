import 'package:flutter_tdd/domain/repositories/local_database_repository.dart';

import 'index.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  LocalDatabaseRepositoryImpl(this._dataSource);
  final LocalDatabaseDataSource _dataSource;

  @override
  Future<void> saveName(String value) =>
      _dataSource.save(LocalDatabaseKey.name.rawValue, value);

  @override
  Future<String> loadName() => _dataSource.load(LocalDatabaseKey.name.rawValue);
}
