import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/const.dart';

import 'detail_row.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    required this.weather,
    super.key,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Constants.weatherDetails,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              DetailRow(
                  icon: Icons.water_drop_outlined,
                  label: Constants.humidity,
                  value: '${weather.main.humidity}%'),
              DetailRow(
                  icon: Icons.compress,
                  label: Constants.pressure,
                  value: '${weather.main.pressure} hPa'
              ),
              DetailRow(
                icon: Icons.air,
                label: Constants.windSpeed,
                value:'${weather.wind.speed} m/s',
              ),
              DetailRow(
                icon: Icons.navigation,
                label: Constants.windDirection,
                value: '${weather.wind.deg}°',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
