import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../providers/location_provider.dart';

Future<void> getLocationPermission(
    BuildContext context, LocationProvider locationProvider) async {
  final permissionStatus = await Geolocator.checkPermission();

  if (permissionStatus == LocationPermission.denied) {
    final result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text('This app needs access to your location.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Сonfirm'),
          ),
        ],
      ),
    );

    if (result == true) {
      requestLocationPermission(locationProvider);
    }
  } else if (permissionStatus == LocationPermission.deniedForever) {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text(
            'Location permission is permanently denied. Please enable it from app settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  } else {
    locationProvider.startTracking();
  }
}

Future<void> requestLocationPermission(
    LocationProvider locationProvider) async {
  final permissionStatus = await Geolocator.requestPermission();

  if (permissionStatus == LocationPermission.whileInUse ||
      permissionStatus == LocationPermission.always) {
    locationProvider.startTracking();
  }
}
