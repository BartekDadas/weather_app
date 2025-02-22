import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/di.dart';
import '../cubits/weather_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../widgets/location_permission_handler.dart';
import '../models/weather.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () => _showThemeDialog(context),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<WeatherCubit>().getCurrentLocationWeather();
              },
            ),
          ],
        ),
        body: LocationPermissionHandler(
          childBuilder: (state) => state.maybeWhen(
            loaded: (weather) => _buildWeatherInfo(weather),
            orElse: () => const SizedBox.shrink(),
          ),
        ),
    );
  }

  Widget _buildWeatherInfo(Weather weather) {
    return RefreshIndicator(
      onRefresh: () async {
        // This will be handled by the cubit
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTemperatureSection(weather),
              const SizedBox(height: 24),
              _buildWeatherDetails(weather),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemperatureSection(Weather weather) {
    final description =
        weather.weather.isNotEmpty ? weather.weather.first.description : '';

    return Center(
      child: Column(
        children: [
          Text(
            weather.cityName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${weather.main.temperature.round()}°C',
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (weather.weather.isNotEmpty) ...[
            Image.network(
              'https://openweathermap.org/img/wn/${weather.weather.first.icon}@2x.png',
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.cloud_queue,
                size: 100,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Text(
                weather.weather.first.description,
                key: ValueKey(weather.weather.first.description),
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            'H:${weather.main.maxTemp.round()}° L:${weather.main.minTemp.round()}°',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(Weather weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weather Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailRow('Humidity', '${weather.main.humidity}%'),
        _buildDetailRow('Pressure', '${weather.main.pressure} hPa'),
        _buildDetailRow('Wind Speed', '${weather.wind.speed} m/s'),
        _buildDetailRow('Wind Direction', '${weather.wind.deg}°'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Light'),
              leading: const Icon(Icons.brightness_5),
              onTap: () {
                context.read<ThemesCubit>().setThemeMode(ThemesMode.light);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dark'),
              leading: const Icon(Icons.brightness_3),
              onTap: () {
                context.read<ThemesCubit>().setThemeMode(ThemesMode.dark);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Auto'),
              leading: const Icon(Icons.brightness_auto),
              onTap: () {
                context.read<ThemesCubit>().setThemeMode(ThemesMode.auto);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
