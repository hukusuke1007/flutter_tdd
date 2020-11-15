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
  Map<String, dynamic> toData() {
    final value = toJson()..remove('createdAt')..remove('updatedAt');
    return value;
  }

  static String get collectionPath => 'player';

  @late
  String get documentPath => '${Player.collectionPath}/$id';
}
