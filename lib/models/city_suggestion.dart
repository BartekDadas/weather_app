import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_suggestion.freezed.dart';
part 'city_suggestion.g.dart';

@freezed
class CitySuggestion with _$CitySuggestion {
  const factory CitySuggestion({
    required String name,
    @JsonKey(name: 'local_names') Map<String, String>? localNames,
    required double lat,
    required double lon,
    required String country,
    String? state,
  }) = _CitySuggestion;

  factory CitySuggestion.fromJson(Map<String, dynamic> json) =>
      _$CitySuggestionFromJson(json);
}
