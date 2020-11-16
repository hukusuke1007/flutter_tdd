import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mockito/mockito.dart';

import 'mock_storage_reference.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {
  final Map<String, File> storedFilesMap = {};
  final Map<String, Uint8List> storedDataMap = {};

  @override
  Reference ref([String path]) {
    return MockStorageReference(this);
  }
}

class MockStorageUploadTask extends Mock implements UploadTask {
  MockStorageUploadTask(this.reference);
  final Reference reference;

  @override
  Future<TaskSnapshot> whenComplete(FutureOr Function() action) =>
      Future.value(MockStorageTaskSnapshot(reference));
}

class MockStorageTaskSnapshot extends Mock implements TaskSnapshot {
  MockStorageTaskSnapshot(this.reference);
  final Reference reference;

  @override
  Reference get ref => reference;
}
