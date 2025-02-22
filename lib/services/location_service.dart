import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Request location permission and handle the response
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return await Geolocator.openLocationSettings();
      }

      // Check location permission status
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Open app settings so user can enable permission
        await Geolocator.openAppSettings();
        throw Exception(
          'Location permissions are permanently denied. Please enable them in your device settings.',
        );
      }

      return permission == LocationPermission.whileInUse || 
             permission == LocationPermission.always;
    } catch (e) {
      throw Exception('Failed to request location permission: $e');
    }
  }

  /// Get the current location coordinates
  Future<Position> getCurrentLocation() async {
    try {
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        throw Exception('Location permission not granted');
      }

      // Try with high accuracy first
      try {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 15),
        );
      } catch (e) {
        // If high accuracy fails, try with medium accuracy
        try {
          return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
            timeLimit: const Duration(seconds: 10),
          );
        } catch (e) {
          // If medium accuracy fails, try with low accuracy
          return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
            timeLimit: const Duration(seconds: 5),
          );
        }
      }
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }
}
