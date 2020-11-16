import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/filename_helper.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'constants.dart';

abstract class FirebaseStorageDataSource {
  Stream<TaskSnapshot> get snapshotEvents;
  Future<String> save(
    File data, {
    @required String dirPath,
    String filename,
    String cacheControl,
    String mimeType = mimeTypeApplicationOctetStream,
    Map<String, String> metadata = const <String, String>{},
  });
  Future<String> gerDownloadUrl(String dirPath, String filename);
  Future<void> delete(String dirPath, String filename);
  void fetch();
  void dispose();
}

class FirebaseStorageDataSourceImpl implements FirebaseStorageDataSource {
  FirebaseStorageDataSourceImpl(this._storage);

  final FirebaseStorage _storage;

  PublishSubject<TaskSnapshot> _uploader;

  @override
  Stream<TaskSnapshot> get snapshotEvents => _uploader.stream;

  @override
  Future<String> save(
    File data, {
    @required String dirPath,
    String filename,
    String cacheControl,
    String mimeType = mimeTypeApplicationOctetStream,
    Map<String, String> metadata = const <String, String>{},
  }) async {
    final _filename = filename ?? FilenameHelper.randomString();
    final path = '$dirPath/$_filename';
    final ref = _storage.ref().child(path);
    final uploadTask = ref.putFile(
      data,
      SettableMetadata(
        cacheControl: cacheControl,
        contentType: mimeType,
        customMetadata: metadata,
      ),
    );
    if (_uploader != null) {
      uploadTask.snapshotEvents.listen(_uploader.add);
    }
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<String> gerDownloadUrl(String dirPath, String filename) =>
      _storage.ref().child('$dirPath/$filename').getDownloadURL();

  @override
  Future<void> delete(String dirPath, String filename) =>
      _storage.ref().child('$dirPath/$filename').delete();

  @override
  void fetch() {
    _uploader ??= PublishSubject<TaskSnapshot>();
  }

  @override
  void dispose() {
    _uploader.close();
    _uploader = null;
  }
}
