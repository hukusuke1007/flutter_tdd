import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tdd/domain/repositories/user_profile_repository.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/user_profile/user_profile.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  UserProfileRepositoryImpl(
    this._documentDataSource,
  );

  final DocumentDataSource _documentDataSource;

  @override
  Future<String> save(UserProfile userProfile) => _documentDataSource.save(
        UserProfile.collectionPath,
        data: <String, dynamic>{
          ...userProfile.toData(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );

  @override
  Future<void> update(String id, UserProfile userProfile) =>
      _documentDataSource.save(
        UserProfile.collectionPath,
        id: id,
        data: <String, dynamic>{
          ...userProfile.toData(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );

  @override
  Future<UserProfile> load(String id) async {
    final snapshot =
        await _documentDataSource.load(UserProfile.collectionPath, id);
    if (!snapshot.exists) {
      return null;
    }
    return UserProfile.fromJson(<String, dynamic>{
      ...snapshot.data(),
      'id': snapshot.id,
    });
  }
}
