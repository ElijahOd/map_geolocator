import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/location_provider.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final currentPosition = locationProvider.currentPosition;

    if (currentPosition == null) {
      return Container();
    }

    final cameraPosition = CameraPosition(
      target: LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      ),
      zoom: 15,
    );

    return SizedBox(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: {
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(
              currentPosition.latitude,
              currentPosition.longitude,
            ),
          ),
        },
      ),
    );
  }
}
