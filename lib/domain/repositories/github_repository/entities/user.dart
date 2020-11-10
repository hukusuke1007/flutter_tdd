import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  factory User({
    int id,
    String login,
    @JsonKey(name: 'avatar_url') String avatarUrl,
  }) = _User;
  User._();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
