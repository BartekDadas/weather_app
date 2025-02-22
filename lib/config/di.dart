import 'package:get_it/get_it.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../cubits/weather_cubit.dart';
import '../cubits/theme_cubit.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Configure Dio
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  
  // Services
  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<WeatherService>(WeatherService(getIt<Dio>()));
  getIt.registerSingleton<LocationService>(LocationService());

  // Cubits
  getIt.registerFactory<WeatherCubit>(() => WeatherCubit(getIt<WeatherService>(), getIt<LocationService>()),);
  getIt.registerFactory<ThemesCubit>(() => ThemesCubit());
}
