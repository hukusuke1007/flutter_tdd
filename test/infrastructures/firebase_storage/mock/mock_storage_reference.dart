import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flamingo/flamingo.dart';
import 'package:mockito/mockito.dart';

import 'firebase_storage_mocks_base.dart';

class MockStorageReference extends Mock implements Reference {
  MockStorageReference(this._storage, [this._path = '']);

  final MockFirebaseStorage _storage;
  final String _path;
  final Map<String, MockStorageReference> children = {};

  @override
  Reference child(String path) {
    if (!children.containsKey(path)) {
      children[path] = MockStorageReference(_storage, '$_path/$path');
    }
    return children[path];
  }

  @override
  UploadTask putFile(File file, [SettableMetadata metadata]) {
    _storage.storedFilesMap[_path] = file;
    return MockStorageUploadTask(this);
  }

  @override
  UploadTask putData(Uint8List data, [SettableMetadata metadata]) {
    _storage.storedDataMap[_path] = data;
    return MockStorageUploadTask(this);
  }

  @override
  Future<void> delete() {
    if (_storage.storedFilesMap.containsKey(_path)) {
      _storage.storedFilesMap.remove(_path);
    }
    if (_storage.storedDataMap.containsKey(_path)) {
      _storage.storedDataMap.remove(_path);
    }
    return Future.value();
  }

  @override
  String get fullPath => _path;

  @override
  Future<String> getBucket() => Future.value('some-bucket');

  @override
  Future<String> getPath() => Future.value(_path);

  @override
  Future<String> getName() => Future.value(_path.split('/').last);

  @override
  FirebaseStorage getStorage() => _storage;

  @override
  Reference getRoot() => MockStorageReference(_storage);

  @override
  Future<String> getDownloadURL() => Future.value(
        _storage.storedFilesMap.containsKey(_path)
            ? 'https://firebase_stogage$_path'
            : null,
      );
}
