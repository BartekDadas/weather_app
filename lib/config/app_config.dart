import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // TODO: Replace with your actual OpenWeather API key
  static String apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  
  static Future<void> initialize() async {
    await dotenv.load();
  }
}
