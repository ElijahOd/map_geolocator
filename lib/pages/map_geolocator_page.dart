import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/map_view.dart';
import '../permissions/location_permission.dart';
import '../providers/location_provider.dart';

class MapGeolocatorPage extends StatelessWidget {
  const MapGeolocatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            locationProvider.isTracking ? 'Stop Tracking' : 'Start Tracking'),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (locationProvider.isTracking &&
                locationProvider.currentPosition != null)
              Text(
                'Your coordinates here:\n'
                'Latitude: ${locationProvider.currentPosition!.latitude}\n'
                'Longitude: ${locationProvider.currentPosition!.longitude}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 50),
            const MapView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (locationProvider.isTracking) {
            locationProvider.stopTracking();
          } else {
            getLocationPermission(context, locationProvider);
          }
        },
        child:
            Icon(locationProvider.isTracking ? Icons.stop : Icons.play_arrow),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
