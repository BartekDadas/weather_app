import 'package:get_it/get_it.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../cubits/weather_cubit.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Configure Dio
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  
  // Services
  getIt.registerLazySingleton(() => dio);
  getIt.registerLazySingleton(() => WeatherService(getIt()));
  getIt.registerLazySingleton(() => LocationService());

  // Cubits
  getIt.registerFactory(() => WeatherCubit(getIt(), getIt()));
}
