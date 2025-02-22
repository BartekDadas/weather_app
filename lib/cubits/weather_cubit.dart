import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../config/app_config.dart';

part 'weather_state.dart';
part 'weather_cubit.freezed.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService _weatherService;
  final LocationService _locationService;

  WeatherCubit(this._weatherService, this._locationService) : super(const WeatherState.initial());

  Future<void> getCurrentLocationWeather() async {
    try {
      emit(const WeatherState.loading());
      final position = await _locationService.getCurrentLocation();
      final weather = await _weatherService.getCurrentWeather(
        position.latitude,
        position.longitude,
        AppConfig.apiKey,
        'metric',
      );
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }

  Future<void> getWeatherByLocation(double latitude, double longitude) async {
    try {
      emit(const WeatherState.loading());
      final weather = await _weatherService.getCurrentWeather(
        latitude,
        longitude,
        AppConfig.apiKey,
        'metric',
      );
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }

  Future<void> getWeatherByCity(String city) async {
    try {
      emit(const WeatherState.loading());
      final weather = await _weatherService.getWeatherByCity(
        city,
        AppConfig.apiKey,
        'metric',
      );
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }
}
