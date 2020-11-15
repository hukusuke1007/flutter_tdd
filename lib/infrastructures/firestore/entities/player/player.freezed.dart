// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
class _$PlayerTearOff {
  const _$PlayerTearOff();

// ignore: unused_element
  _Player call(
      {String id,
      String name,
      @DateTimeConverter() DateTime updatedAt,
      @DateTimeConverter() DateTime createdAt}) {
    return _Player(
      id: id,
      name: name,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

// ignore: unused_element
  Player fromJson(Map<String, Object> json) {
    return Player.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Player = _$PlayerTearOff();

/// @nodoc
mixin _$Player {
  String get id;
  String get name;
  @DateTimeConverter()
  DateTime get updatedAt;
  @DateTimeConverter()
  DateTime get createdAt;

  Map<String, dynamic> toJson();
  $PlayerCopyWith<Player> get copyWith;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      @DateTimeConverter() DateTime updatedAt,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res> implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  final Player _value;
  // ignore: unused_field
  final $Res Function(Player) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object updatedAt = freezed,
    Object createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) then) =
      __$PlayerCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      @DateTimeConverter() DateTime updatedAt,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$PlayerCopyWithImpl<$Res> extends _$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(_Player _value, $Res Function(_Player) _then)
      : super(_value, (v) => _then(v as _Player));

  @override
  _Player get _value => super._value as _Player;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object updatedAt = freezed,
    Object createdAt = freezed,
  }) {
    return _then(_Player(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Player extends _Player {
  _$_Player(
      {this.id,
      this.name,
      @DateTimeConverter() this.updatedAt,
      @DateTimeConverter() this.createdAt})
      : super._();

  factory _$_Player.fromJson(Map<String, dynamic> json) =>
      _$_$_PlayerFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @DateTimeConverter()
  final DateTime updatedAt;
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  bool _diddocumentPath = false;
  String _documentPath;

  @override
  String get documentPath {
    if (_diddocumentPath == false) {
      _diddocumentPath = true;
      _documentPath = '$collectionPath/$id';
    }
    return _documentPath;
  }

  @override
  String toString() {
    return 'Player(id: $id, name: $name, updatedAt: $updatedAt, createdAt: $createdAt, documentPath: $documentPath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Player &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(createdAt);

  @override
  _$PlayerCopyWith<_Player> get copyWith =>
      __$PlayerCopyWithImpl<_Player>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PlayerToJson(this);
  }
}

abstract class _Player extends Player {
  _Player._() : super._();
  factory _Player(
      {String id,
      String name,
      @DateTimeConverter() DateTime updatedAt,
      @DateTimeConverter() DateTime createdAt}) = _$_Player;

  factory _Player.fromJson(Map<String, dynamic> json) = _$_Player.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @DateTimeConverter()
  DateTime get updatedAt;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  _$PlayerCopyWith<_Player> get copyWith;
}
