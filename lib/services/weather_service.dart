import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/weather.dart';
import '../config/app_config.dart';

part 'weather_service.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class WeatherService {
  factory WeatherService(Dio dio) = _WeatherService;

  @GET('/weather')
  Future<Weather> getCurrentWeather(
    @Query('lat') double latitude,
    @Query('lon') double longitude,
    @Query('appid') String apiKey,
    @Query('units') String units,
  );

  @GET('/weather')
  Future<Weather> getWeatherByCity(
    @Query('q') String city,
    @Query('appid') String apiKey,
    @Query('units') String units,
  );
}
