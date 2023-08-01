import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/location_provider.dart';

class CopyCoordinate extends StatefulWidget {
  const CopyCoordinate({Key? key}) : super(key: key);

  @override
  State<CopyCoordinate> createState() => _CopyCoordinateState();
}

class _CopyCoordinateState extends State<CopyCoordinate> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final currentPosition = locationProvider.currentPosition;

    if (currentPosition == null) {
      return Container();
    }

    return FloatingActionButton(
      onPressed: () {
        final coordinates =
            '${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude}';

        const snackBar = SnackBar(
          content: Text('Coordinates copied!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _copied = true;
          print(coordinates);
        });
      },
      backgroundColor: Colors.black87,
      child: _copied ? const Icon(Icons.check) : const Icon(Icons.copy),
    );
  }
}
