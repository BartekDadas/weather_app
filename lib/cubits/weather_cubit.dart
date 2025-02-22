import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather.dart';
import '../models/city_suggestion.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../config/app_config.dart';

part 'weather_state.dart';
part 'weather_cubit.freezed.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService _weatherService;
  final LocationService _locationService;
  List<CitySuggestion> _currentSuggestions = [];

  WeatherCubit(this._weatherService, this._locationService) : super(const WeatherState.initial());

  List<CitySuggestion> get currentSuggestions => _currentSuggestions;

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
      _currentSuggestions = []; // Clear suggestions after successful search
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }

  Future<void> updateCitySuggestions(String query) async {
    print('Updating suggestions for query: $query');
    if (query.trim().isEmpty) {
      print('Empty query, clearing suggestions');
      _currentSuggestions = [];
      emit(state); // Force a rebuild
      return;
    }

    try {
      print('Fetching suggestions from API');
      _currentSuggestions = await _weatherService.getCitySuggestions(
        query,
        5, // Limit to 5 suggestions
        AppConfig.apiKey,
      );
      print('Received ${_currentSuggestions.length} suggestions');
      emit(state); // Force a rebuild
    } catch (e) {
      print('Error fetching suggestions: $e');
      _currentSuggestions = [];
      emit(state); // Force a rebuild
    }
  }
}
