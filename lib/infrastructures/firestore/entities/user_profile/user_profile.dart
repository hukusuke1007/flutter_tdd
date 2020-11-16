import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tdd/infrastructures/firebase_storage/entities/storage_file/storage_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../date_time_converter.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  factory UserProfile({
    String id,
    String name,
    StorageFile image,
    @DateTimeConverter() DateTime createdAt,
    @DateTimeConverter() DateTime updatedAt,
  }) = _UserProfile;
  UserProfile._();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  static String get collectionPath => 'userProfiles';

  static String get imageFilename => 'user_image';

  Map<String, dynamic> toData() =>
      toJson()..remove('createdAt')..remove('updatedAt');

  @late
  String get documentPath => '${UserProfile.collectionPath}/$id';
}
