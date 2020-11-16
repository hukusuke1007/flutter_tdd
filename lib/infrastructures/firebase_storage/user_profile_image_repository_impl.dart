import 'dart:async';
import 'dart:io';

import 'package:flutter_tdd/domain/repositories/user_profile_image_repository.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/constants.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/entities/storage_file/storage_file.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/firebase_storage_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';

import 'constants.dart';

class UserProfileImageRepositoryImpl implements UserProfileImageRepository {
  UserProfileImageRepositoryImpl(this._dataSource);

  final FirebaseStorageDataSource _dataSource;

  @override
  Future<StorageFile> save(
    File data,
    String userId, {
    String mimeType = mimeTypeApplicationOctetStream,
  }) async {
    final dirPath = '${UserProfile.collectionPath}/$userId';
    final filename = UserProfile.imageFilename;
    final url =
        await _dataSource.save(data, dirPath: dirPath, filename: filename);
    return StorageFile(
      url: url,
      path: '$dirPath/$filename',
      mimeType: mimeType,
    );
  }

  @override
  Future<void> delete(String userId) async {
    final dirPath = '${UserProfile.collectionPath}/$userId';
    final filename = UserProfile.imageFilename;
    await _dataSource.delete(dirPath, filename);
  }
}
