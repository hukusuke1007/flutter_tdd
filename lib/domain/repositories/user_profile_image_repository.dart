import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/constants.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/entities/storage_file/storage_file.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/firebase_storage_data_source.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/user_profile_image_repository_impl.dart';
import 'package:hooks_riverpod/all.dart';

final userProfileImageRepositoryProvider =
    Provider<UserProfileImageRepository>((_) {
  final dataSource = FirebaseStorageDataSourceImpl(FirebaseStorage.instance);
  return UserProfileImageRepositoryImpl(dataSource);
});

abstract class UserProfileImageRepository {
  Future<StorageFile> save(
    File data,
    String userId, {
    String mimeType = mimeTypeApplicationOctetStream,
  });
  Future<void> delete(String userId);
}
