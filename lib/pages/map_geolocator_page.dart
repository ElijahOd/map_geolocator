import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/copy_coordinate.dart';
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
              RealTimeCoordinatesWidget(), // Замінено на новий віджет
            const SizedBox(height: 20),
            const CopyCoordinate(),
            const SizedBox(height: 20),
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

// Новий віджет для відображення координат в реальному часі
class RealTimeCoordinatesWidget extends StatefulWidget {
  const RealTimeCoordinatesWidget({Key? key}) : super(key: key);

  @override
  State<RealTimeCoordinatesWidget> createState() =>
      _RealTimeCoordinatesWidgetState();
}

class _RealTimeCoordinatesWidgetState extends State<RealTimeCoordinatesWidget> {
  @override
  void initState() {
    super.initState();
    // Підпишіться на зміни координат
    Provider.of<LocationProvider>(context, listen: false)
        .addListener(_onLocationChange);
  }

  @override
  void dispose() {
    // Видаліть підписку при знищенні віджету
    Provider.of<LocationProvider>(context, listen: false)
        .removeListener(_onLocationChange);
    super.dispose();
  }

  void _onLocationChange() {
    // Викликається при зміні координат
    setState(() {}); // Оновіть стан віджету, щоб відобразити нові координати
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final currentPosition = locationProvider.currentPosition;
    if (currentPosition == null) {
      return Container();
    }
    return Text(
      'Your coordinates here:\n'
      'Latitude: ${currentPosition.latitude}\n'
      'Longitude: ${currentPosition.longitude}',
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
