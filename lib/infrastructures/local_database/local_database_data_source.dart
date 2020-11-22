import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatabaseDataSource {
  Future<bool> save<T>(String key, T value);
  Future<T> load<T>(String key);
  Future<bool> remove(String key);
}

class LocalDatabaseDataSourceImpl implements LocalDatabaseDataSource {
  LocalDatabaseDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool> save<T>(String key, T value) async {
    if (value is int) {
      return _prefs.setInt(key, value);
    }
    if (value is double) {
      return _prefs.setDouble(key, value);
    }
    if (value is bool) {
      return _prefs.setBool(key, value);
    }
    if (value is String) {
      return _prefs.setString(key, value);
    }
    if (value is List<String>) {
      return _prefs.setStringList(key, value);
    }
    return false;
  }

  @override
  Future<T> load<T>(String key) async {
    if (T.toString() == 'int') {
      return _prefs.getInt(key) as T;
    }
    if (T.toString() == 'double') {
      return _prefs.getDouble(key) as T;
    }
    if (T.toString() == 'bool') {
      return _prefs.getBool(key) as T;
    }
    if (T.toString() == 'String') {
      return _prefs.getString(key) as T;
    }
    if (T.toString() == 'List<String>') {
      return _prefs.getStringList(key) as T;
    }
    return null;
  }

  @override
  Future<bool> remove(String key) => _prefs.remove(key);
}
