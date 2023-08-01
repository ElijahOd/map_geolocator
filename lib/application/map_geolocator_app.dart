import 'package:flutter/material.dart';
import 'package:map_geolocator/pages/map_geolocator_page.dart';
import 'package:map_geolocator/providers/location_provider.dart';
import 'package:provider/provider.dart';

class MapGeolocatorApp extends StatelessWidget {
  const MapGeolocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationProvider(),
      child: const MaterialApp(
        title: 'Location Tracker by OD',
        home: MapGeolocatorPage(),
      ),
    );
  }
}
