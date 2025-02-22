import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/weather.dart';
import '../models/city_suggestion.dart';
import '../config/app_config.dart';

part 'weather_service.g.dart';

@RestApi()
abstract class WeatherService {
  factory WeatherService(Dio dio) = _WeatherService;

  @GET('${AppConfig.baseUrl}/weather')
  Future<Weather> getCurrentWeather(
    @Query('lat') double latitude,
    @Query('lon') double longitude,
    @Query('appid') String apiKey,
    @Query('units') String units,
  );

  @GET('${AppConfig.baseUrl}/weather')
  Future<Weather> getWeatherByCity(
    @Query('q') String city,
    @Query('appid') String apiKey,
    @Query('units') String units,
  );

  @GET('http://api.openweathermap.org/geo/1.0/direct')
  Future<List<CitySuggestion>> getCitySuggestions(
    @Query('q') String query,
    @Query('limit') int limit,
    @Query('appid') String apiKey,
  );
}
