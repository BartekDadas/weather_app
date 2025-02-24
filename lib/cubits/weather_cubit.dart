import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final SharedPreferences _prefs;
  List<CitySuggestion> _currentSuggestions = [];
  static const String _favoritesKey = 'favorite_locations';

  WeatherCubit(this._weatherService, this._locationService, this._prefs)
      : super(WeatherState.initial(
          favoriteLocations: _prefs.getStringList(_favoritesKey) ?? [],
        ));

  List<CitySuggestion> get currentSuggestions => _currentSuggestions;
  List<String> get favoriteLocations => state.favoriteLocations;

  Future<void> addToFavorites(String location) async {
    final currentState = state;
    final currentFavorites = List<String>.from(state.favoriteLocations);
    
    if (!currentFavorites.contains(location)) {
      currentFavorites.add(location);
      await _prefs.setStringList(_favoritesKey, currentFavorites);
      
      emit(currentState.copyWith(favoriteLocations: currentFavorites));
    }
  }

  Future<void> removeFromFavorites(String location) async {
    final currentState = state;
    final currentFavorites = List<String>.from(state.favoriteLocations);
    
    if (currentFavorites.remove(location)) {
      await _prefs.setStringList(_favoritesKey, currentFavorites);
      
      emit(currentState.copyWith(favoriteLocations: currentFavorites));
    }
  }

  bool isFavorite(String location) {
    return state.favoriteLocations.contains(location);
  }

  Future<void> getCurrentLocationWeather() async {
    try {
      emit(WeatherState.loading(favoriteLocations: state.favoriteLocations));
      final position = await _locationService.getCurrentLocation();
      final weather = await _weatherService.getCurrentWeather(
        position.latitude,
        position.longitude,
        AppConfig.apiKey,
        'metric',
      );
      emit(WeatherState.loaded(weather, favoriteLocations: state.favoriteLocations));
    } catch (e) {
      emit(WeatherState.error(e.toString(), favoriteLocations: state.favoriteLocations));
    }
  }

  Future<void> getWeatherByLocation(double latitude, double longitude) async {
    try {
      emit(WeatherState.loading(favoriteLocations: state.favoriteLocations));
      final weather = await _weatherService.getCurrentWeather(
        latitude,
        longitude,
        AppConfig.apiKey,
        'metric',
      );
      emit(WeatherState.loaded(weather, favoriteLocations: state.favoriteLocations));
    } catch (e) {
      emit(WeatherState.error(e.toString(), favoriteLocations: state.favoriteLocations));
    }
  }

  Future<void> getWeatherByCity(String city) async {
    try {
      emit(WeatherState.loading(favoriteLocations: state.favoriteLocations));
      final weather = await _weatherService.getWeatherByCity(
        city,
        AppConfig.apiKey,
        'metric',
      );
      _currentSuggestions = [];
      emit(WeatherState.loaded(weather, favoriteLocations: state.favoriteLocations));
    } catch (e) {
      emit(WeatherState.error(e.toString(), favoriteLocations: state.favoriteLocations));
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
