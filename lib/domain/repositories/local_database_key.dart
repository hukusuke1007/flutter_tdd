enum LocalDatabaseKey {
  name,
}

extension LocalDatabaseKeyExtension on LocalDatabaseKey {
  String get rawValue {
    switch (this) {
      case LocalDatabaseKey.name:
        return 'name';
    }
    return null;
  }
}
