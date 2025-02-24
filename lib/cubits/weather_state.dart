part of 'weather_cubit.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial({
    @Default([]) List<String> favoriteLocations,
  }) = _Initial;
  
  const factory WeatherState.loading({
    @Default([]) List<String> favoriteLocations,
  }) = _Loading;
  
  const factory WeatherState.loaded(
    Weather weather, {
    @Default([]) List<String> favoriteLocations,
  }) = _Loaded;
  
  const factory WeatherState.error(
    String message, {
    @Default([]) List<String> favoriteLocations,
  }) = _Error;
}
