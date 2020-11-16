// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
class _$UserProfileTearOff {
  const _$UserProfileTearOff();

// ignore: unused_element
  _UserProfile call(
      {String id,
      String name,
      StorageFile image,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt}) {
    return _UserProfile(
      id: id,
      name: name,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

// ignore: unused_element
  UserProfile fromJson(Map<String, Object> json) {
    return UserProfile.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $UserProfile = _$UserProfileTearOff();

/// @nodoc
mixin _$UserProfile {
  String get id;
  String get name;
  StorageFile get image;
  @DateTimeConverter()
  DateTime get createdAt;
  @DateTimeConverter()
  DateTime get updatedAt;

  Map<String, dynamic> toJson();
  $UserProfileCopyWith<UserProfile> get copyWith;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      StorageFile image,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt});

  $StorageFileCopyWith<$Res> get image;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res> implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  final UserProfile _value;
  // ignore: unused_field
  final $Res Function(UserProfile) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object image = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      image: image == freezed ? _value.image : image as StorageFile,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }

  @override
  $StorageFileCopyWith<$Res> get image {
    if (_value.image == null) {
      return null;
    }
    return $StorageFileCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value));
    });
  }
}

/// @nodoc
abstract class _$UserProfileCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(
          _UserProfile value, $Res Function(_UserProfile) then) =
      __$UserProfileCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      StorageFile image,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt});

  @override
  $StorageFileCopyWith<$Res> get image;
}

/// @nodoc
class __$UserProfileCopyWithImpl<$Res> extends _$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(
      _UserProfile _value, $Res Function(_UserProfile) _then)
      : super(_value, (v) => _then(v as _UserProfile));

  @override
  _UserProfile get _value => super._value as _UserProfile;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object image = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_UserProfile(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      image: image == freezed ? _value.image : image as StorageFile,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_UserProfile extends _UserProfile {
  _$_UserProfile(
      {this.id,
      this.name,
      this.image,
      @DateTimeConverter() this.createdAt,
      @DateTimeConverter() this.updatedAt})
      : super._();

  factory _$_UserProfile.fromJson(Map<String, dynamic> json) =>
      _$_$_UserProfileFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final StorageFile image;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @DateTimeConverter()
  final DateTime updatedAt;

  bool _diddocumentPath = false;
  String _documentPath;

  @override
  String get documentPath {
    if (_diddocumentPath == false) {
      _diddocumentPath = true;
      _documentPath = '${UserProfile.collectionPath}/$id';
    }
    return _documentPath;
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, documentPath: $documentPath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserProfile &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @override
  _$UserProfileCopyWith<_UserProfile> get copyWith =>
      __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserProfileToJson(this);
  }
}

abstract class _UserProfile extends UserProfile {
  _UserProfile._() : super._();
  factory _UserProfile(
      {String id,
      String name,
      StorageFile image,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt}) = _$_UserProfile;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$_UserProfile.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  StorageFile get image;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @DateTimeConverter()
  DateTime get updatedAt;
  @override
  _$UserProfileCopyWith<_UserProfile> get copyWith;
}
