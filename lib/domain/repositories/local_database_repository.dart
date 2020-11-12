abstract class LocalDatabaseRepository {
  Future<void> saveName(String value);
  Future<String> loadName();
}
