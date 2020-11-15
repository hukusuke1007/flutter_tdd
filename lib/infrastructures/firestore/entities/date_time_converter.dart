import 'package:flamingo/flamingo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Timestamp value) => value?.toDate();

  @override
  Timestamp toJson(DateTime object) =>
      object != null ? Timestamp.fromDate(object) : null;
}
