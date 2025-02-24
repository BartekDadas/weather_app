import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/weather_cubit.dart';

class LocationPermissionHandler extends StatelessWidget {
  final Widget Function(WeatherState) childBuilder;

  const LocationPermissionHandler({
    super.key,
    required this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        print(state);
        return state.when(
          initial: (_) => PermissionRequestWidget(
            onPressed: () {
              context.read<WeatherCubit>().getCurrentLocationWeather();
            },
          ),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          loaded: (_, __) => childBuilder(state),
          error: (error, _) => ErrorWidget(error: error, onPressed: () {
            context.read<WeatherCubit>().getCurrentLocationWeather();
          }),
        );
      },
    );
  }
}

class PermissionRequestWidget extends StatelessWidget {
  const PermissionRequestWidget({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on,
            size: 64,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          const Text(
            'Location Permission Required',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'We need access to your location to provide accurate weather information for your area.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }
}


class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    required this.error,
    required this.onPressed,
    super.key
  });

  final String error;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
