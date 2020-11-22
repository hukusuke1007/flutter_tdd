import 'dart:io';

import 'package:flutter_tdd/domain/repositories/user_profile_image_cache_repository.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';
import 'package:flutter_tdd/infrastructures/local_storage/local_storage_data_source.dart';

class UserProfileImageCacheRepositoryImpl
    implements UserProfileImageCacheRepository {
  UserProfileImageCacheRepositoryImpl(this._dataSource);

  final LocalStorageDataSource _dataSource;

  String get _filename => UserProfile.imageFilename;

  @override
  void save(File file) => _dataSource.save(file, _filename);

  @override
  File load() => _dataSource.load(_filename);

  @override
  void delete() => _dataSource.remove(_filename);

  @override
  bool isExist() => _dataSource.isExist(_filename);
}
