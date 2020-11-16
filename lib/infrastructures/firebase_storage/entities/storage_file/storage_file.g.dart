// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StorageFile _$_$_StorageFileFromJson(Map<String, dynamic> json) {
  return _$_StorageFile(
    url: json['url'] as String,
    path: json['path'] as String,
    mimeType: json['mimeType'] as String,
    metadata: (json['metadata'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$_$_StorageFileToJson(_$_StorageFile instance) =>
    <String, dynamic>{
      'url': instance.url,
      'path': instance.path,
      'mimeType': instance.mimeType,
      'metadata': instance.metadata,
    };
