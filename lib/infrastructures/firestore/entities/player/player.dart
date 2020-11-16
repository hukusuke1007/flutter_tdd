import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../date_time_converter.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
abstract class Player with _$Player {
  factory Player({
    String id,
    String name,
    @DateTimeConverter() DateTime createdAt,
    @DateTimeConverter() DateTime updatedAt,
  }) = _Player;
  Player._();

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  static String get collectionPath => 'players';

  Map<String, dynamic> toData() =>
      toJson()..remove('createdAt')..remove('updatedAt');

  @late
  String get documentPath => '${Player.collectionPath}/$id';
}
