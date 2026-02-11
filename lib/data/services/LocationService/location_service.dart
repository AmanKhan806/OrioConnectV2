import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return false;
    }

    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return null;

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      log('Error getting current position: $e');
      return null;
    }
  }

  static Future<bool> isLocationPermissionPermanentlyDenied() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.deniedForever;
  }

  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  static double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // LocationService.dart
  static Future<LocationValidationResult> validateOfficeLocation({
    required String officeLatitude,
    required String officeLongitude,
    required String officeRadius,
  }) async {
    try {
      final officeLat = double.tryParse(officeLatitude);
      final officeLng = double.tryParse(officeLongitude);
      final radius = double.tryParse(officeRadius);

      if (officeLat == null || officeLng == null || radius == null) {
        return LocationValidationResult(
          isInRange: false,
          message: 'Invalid office coordinates',
          distance: null,
        );
      }

      final position = await getCurrentPosition();

      if (position == null) {
        final permission = await Geolocator.checkPermission();
        final serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (!serviceEnabled) {
          return LocationValidationResult(
            isInRange: false,
            message: 'Location service is turned off. Please enable it.',
            distance: null,
          );
        }

        // IMPORTANT: Check deniedForever first
        if (permission == LocationPermission.deniedForever) {
          return LocationValidationResult(
            isInRange: false,
            message:
                'Location permission denied. Tap here to enable in settings.', // Updated message
            distance: null,
          );
        }

        if (permission == LocationPermission.denied) {
          return LocationValidationResult(
            isInRange: false,
            message:
                'Location permission required. Please allow location access.',
            distance: null,
          );
        }

        return LocationValidationResult(
          isInRange: false,
          message: 'Unable to get your location.',
          distance: null,
        );
      }

      final distance = calculateDistance(
        startLatitude: position.latitude,
        startLongitude: position.longitude,
        endLatitude: officeLat,
        endLongitude: officeLng,
      );

      log('Current Location: ${position.latitude}, ${position.longitude}');
      log('Office Location: $officeLat, $officeLng');
      log('Distance: ${distance.toStringAsFixed(2)} meters');
      log('Allowed Radius: $radius meters');

      final isInRange = distance <= radius;

      return LocationValidationResult(
        isInRange: isInRange,
        message: isInRange
            ? 'You are in office range'
            : 'You are ${distance.toStringAsFixed(0)}m away from office (Allowed: ${radius.toStringAsFixed(0)}m)',
        distance: distance,
        currentLatitude: position.latitude,
        currentLongitude: position.longitude,
      );
    } catch (e) {
      log('Error validating location: $e');
      return LocationValidationResult(
        isInRange: false,
        message: 'Error validating location',
        distance: null,
      );
    }
  }

  static Future<LocationPermissionStatus>
  checkLocationPermissionStatus() async {
    final permission = await Geolocator.checkPermission();
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return LocationPermissionStatus.serviceDisabled;
    }

    switch (permission) {
      case LocationPermission.denied:
        return LocationPermissionStatus.notRequested;
      case LocationPermission.deniedForever:
        return LocationPermissionStatus.permanentlyDenied;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        return LocationPermissionStatus.granted;
      default:
        return LocationPermissionStatus.notRequested;
    }
  }

  static Future<bool> isLocationPermissionDenied() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.deniedForever;
  }
}

class LocationValidationResult {
  final bool isInRange;
  final String message;
  final double? distance;
  final double? currentLatitude;
  final double? currentLongitude;

  LocationValidationResult({
    required this.isInRange,
    required this.message,
    this.distance,
    this.currentLatitude,
    this.currentLongitude,
  });
}

enum LocationPermissionStatus {
  granted,
  notRequested,
  permanentlyDenied,
  serviceDisabled,
}
