import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_geolocator/pages/map_geolocator_page.dart';
import 'package:provider/provider.dart';

import '../cubit/location_cubit.dart';
import '../providers/location_provider.dart';

class MapGeolocatorApp extends StatelessWidget {
  const MapGeolocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        title: 'Location Tracker by OD',
        home: BlocProvider(
          create: (context) => LocationCubit(),
          child: const MapGeolocatorPage(),
        ),
      ),
    );
  }
}
