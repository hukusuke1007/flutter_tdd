import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';
import 'package:flutter_tdd/infrastructures/firestore/user_profile_repository_impl.dart';
import 'package:hooks_riverpod/all.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((_) {
  final dataSource = DocumentDataSourceImpl(FirebaseFirestore.instance);
  return UserProfileRepositoryImpl(dataSource);
});

abstract class UserProfileRepository {
  Future<String> save(UserProfile userProfile);
  Future<void> update(String id, UserProfile userProfile);
  Future<UserProfile> load(String id);
}
