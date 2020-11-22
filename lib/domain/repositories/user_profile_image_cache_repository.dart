import 'dart:io';

import 'package:flutter_tdd/infrastructures/local_storage/index.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:path_provider/path_provider.dart';

final userProfileImageCacheRepositoryProvider =
    FutureProvider<UserProfileImageCacheRepository>((_) async {
  final dir = await getApplicationDocumentsDirectory();
  final dataSource = LocalStorageDataSourceImpl(dir.path);
  return UserProfileImageCacheRepositoryImpl(dataSource);
});

abstract class UserProfileImageCacheRepository {
  void save(File file);
  File load();
  void delete();
  bool isExist();
}
