// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProfile _$_$_UserProfileFromJson(Map<String, dynamic> json) {
  return _$_UserProfile(
    id: json['id'] as String,
    name: json['name'] as String,
    image: json['image'] == null
        ? null
        : StorageFile.fromJson(json['image'] as Map<String, dynamic>),
    createdAt:
        const DateTimeConverter().fromJson(json['createdAt'] as Timestamp),
    updatedAt:
        const DateTimeConverter().fromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_UserProfileToJson(_$_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };
