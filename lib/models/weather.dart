import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    @JsonKey(name: 'main') required WeatherMain main,
    @JsonKey(name: 'weather') required List<WeatherDescription> weather,
    @JsonKey(name: 'wind') required Wind wind,
    @JsonKey(name: 'name') required String cityName,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
}

@freezed
class WeatherMain with _$WeatherMain {
  const factory WeatherMain({
    @JsonKey(name: 'temp') required double temperature,
    @JsonKey(name: 'feels_like') required double feelsLike,
    @JsonKey(name: 'temp_min') required double minTemp,
    @JsonKey(name: 'temp_max') required double maxTemp,
    required int humidity,
    required double pressure,
  }) = _WeatherMain;

  factory WeatherMain.fromJson(Map<String, dynamic> json) => _$WeatherMainFromJson(json);
}

@freezed
class WeatherDescription with _$WeatherDescription {
  const factory WeatherDescription({
    required String main,
    required String description,
    required String icon,
  }) = _WeatherDescription;

  factory WeatherDescription.fromJson(Map<String, dynamic> json) => _$WeatherDescriptionFromJson(json);
}

@freezed
class Wind with _$Wind {
  const factory Wind({
    @JsonKey(name: 'speed') required double speed,
    @JsonKey(name: 'deg') required int deg,
  }) = _Wind;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}
