import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../utils/const.dart';

class TemperatureSection extends StatelessWidget {
  const TemperatureSection({
    required this.weather,
    super.key,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
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
            weather.weather.first.icon == Constants.cleanSkyIcon
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(
                    Icons.wb_sunny,
                    size: 80,
                  ),)
                :
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
}
