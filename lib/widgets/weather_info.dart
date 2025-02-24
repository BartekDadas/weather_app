import 'package:flutter/material.dart';
import 'package:weather_app/widgets/temperature_section.dart';
import 'package:weather_app/widgets/weather_details.dart';

import '../models/weather.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    required this.weather,
    super.key
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
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
              TemperatureSection(weather: weather),
              const SizedBox(height: 24),
              WeatherDetails(weather: weather),
            ],
          ),
        ),
      ),
    );
  }
}
