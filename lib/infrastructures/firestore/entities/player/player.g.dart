// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Player _$_$_PlayerFromJson(Map<String, dynamic> json) {
  return _$_Player(
    id: json['id'] as String,
    name: json['name'] as String,
    updatedAt:
        const DateTimeConverter().fromJson(json['updatedAt'] as Timestamp),
    createdAt:
        const DateTimeConverter().fromJson(json['createdAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_PlayerToJson(_$_Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };
