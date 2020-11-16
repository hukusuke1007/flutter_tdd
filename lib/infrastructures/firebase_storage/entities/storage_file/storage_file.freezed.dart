// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'storage_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
StorageFile _$StorageFileFromJson(Map<String, dynamic> json) {
  return _StorageFile.fromJson(json);
}

/// @nodoc
class _$StorageFileTearOff {
  const _$StorageFileTearOff();

// ignore: unused_element
  _StorageFile call(
      {String url,
      String path,
      String mimeType,
      Map<String, String> metadata}) {
    return _StorageFile(
      url: url,
      path: path,
      mimeType: mimeType,
      metadata: metadata,
    );
  }

// ignore: unused_element
  StorageFile fromJson(Map<String, Object> json) {
    return StorageFile.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $StorageFile = _$StorageFileTearOff();

/// @nodoc
mixin _$StorageFile {
  String get url;
  String get path;
  String get mimeType;
  Map<String, String> get metadata;

  Map<String, dynamic> toJson();
  $StorageFileCopyWith<StorageFile> get copyWith;
}

/// @nodoc
abstract class $StorageFileCopyWith<$Res> {
  factory $StorageFileCopyWith(
          StorageFile value, $Res Function(StorageFile) then) =
      _$StorageFileCopyWithImpl<$Res>;
  $Res call(
      {String url, String path, String mimeType, Map<String, String> metadata});
}

/// @nodoc
class _$StorageFileCopyWithImpl<$Res> implements $StorageFileCopyWith<$Res> {
  _$StorageFileCopyWithImpl(this._value, this._then);

  final StorageFile _value;
  // ignore: unused_field
  final $Res Function(StorageFile) _then;

  @override
  $Res call({
    Object url = freezed,
    Object path = freezed,
    Object mimeType = freezed,
    Object metadata = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed ? _value.url : url as String,
      path: path == freezed ? _value.path : path as String,
      mimeType: mimeType == freezed ? _value.mimeType : mimeType as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata as Map<String, String>,
    ));
  }
}

/// @nodoc
abstract class _$StorageFileCopyWith<$Res>
    implements $StorageFileCopyWith<$Res> {
  factory _$StorageFileCopyWith(
          _StorageFile value, $Res Function(_StorageFile) then) =
      __$StorageFileCopyWithImpl<$Res>;
  @override
  $Res call(
      {String url, String path, String mimeType, Map<String, String> metadata});
}

/// @nodoc
class __$StorageFileCopyWithImpl<$Res> extends _$StorageFileCopyWithImpl<$Res>
    implements _$StorageFileCopyWith<$Res> {
  __$StorageFileCopyWithImpl(
      _StorageFile _value, $Res Function(_StorageFile) _then)
      : super(_value, (v) => _then(v as _StorageFile));

  @override
  _StorageFile get _value => super._value as _StorageFile;

  @override
  $Res call({
    Object url = freezed,
    Object path = freezed,
    Object mimeType = freezed,
    Object metadata = freezed,
  }) {
    return _then(_StorageFile(
      url: url == freezed ? _value.url : url as String,
      path: path == freezed ? _value.path : path as String,
      mimeType: mimeType == freezed ? _value.mimeType : mimeType as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata as Map<String, String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_StorageFile extends _StorageFile {
  _$_StorageFile({this.url, this.path, this.mimeType, this.metadata})
      : super._();

  factory _$_StorageFile.fromJson(Map<String, dynamic> json) =>
      _$_$_StorageFileFromJson(json);

  @override
  final String url;
  @override
  final String path;
  @override
  final String mimeType;
  @override
  final Map<String, String> metadata;

  @override
  String toString() {
    return 'StorageFile(url: $url, path: $path, mimeType: $mimeType, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StorageFile &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.mimeType, mimeType) ||
                const DeepCollectionEquality()
                    .equals(other.mimeType, mimeType)) &&
            (identical(other.metadata, metadata) ||
                const DeepCollectionEquality()
                    .equals(other.metadata, metadata)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(mimeType) ^
      const DeepCollectionEquality().hash(metadata);

  @override
  _$StorageFileCopyWith<_StorageFile> get copyWith =>
      __$StorageFileCopyWithImpl<_StorageFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_StorageFileToJson(this);
  }
}

abstract class _StorageFile extends StorageFile {
  _StorageFile._() : super._();
  factory _StorageFile(
      {String url,
      String path,
      String mimeType,
      Map<String, String> metadata}) = _$_StorageFile;

  factory _StorageFile.fromJson(Map<String, dynamic> json) =
      _$_StorageFile.fromJson;

  @override
  String get url;
  @override
  String get path;
  @override
  String get mimeType;
  @override
  Map<String, String> get metadata;
  @override
  _$StorageFileCopyWith<_StorageFile> get copyWith;
}
