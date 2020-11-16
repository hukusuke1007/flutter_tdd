import 'dart:async';
import 'dart:io';

import 'package:flutter_tdd/infrastructures/firebase_storage/constants.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/entities/storage_file/storage_file.dart';

abstract class UserProfileImageRepository {
  Future<StorageFile> save(
    File data,
    String userId, {
    String mimeType = mimeTypeApplicationOctetStream,
  });
  Future<void> delete(String userId);
}
