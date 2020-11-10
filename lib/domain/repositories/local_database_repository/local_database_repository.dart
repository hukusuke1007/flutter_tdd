import '../../../infrastructures/local_database/index.dart';
import 'local_database_key.dart';

abstract class LocalDatabaseRepository {
  Future<void> saveName(String value);
  Future<String> loadName();
}

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
