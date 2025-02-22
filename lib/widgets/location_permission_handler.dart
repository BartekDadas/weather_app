import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/weather_cubit.dart';

class LocationPermissionHandler extends StatelessWidget {
  final Widget child;

  const LocationPermissionHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildPermissionRequest(context),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (_) => child,
          error: (error) => _buildError(context, error),
        );
      },
    );
  }

  Widget _buildPermissionRequest(BuildContext context) {
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
            onPressed: () {
              context.read<WeatherCubit>().getCurrentLocationWeather();
            },
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Center(
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
            onPressed: () {
              context.read<WeatherCubit>().getCurrentLocationWeather();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
