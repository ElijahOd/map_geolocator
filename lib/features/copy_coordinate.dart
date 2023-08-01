import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';

class CopyCoordinate extends StatelessWidget {
  const CopyCoordinate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_CopyCoordinateState>(
      create: (_) => _CopyCoordinateState(),
      child: Builder(builder: (context) {
        final locationProvider = Provider.of<LocationProvider>(context);
        final currentPosition = locationProvider.currentPosition;

        if (currentPosition == null) {
          return Container();
        }

        final copiedState = Provider.of<_CopyCoordinateState>(context);

        return FloatingActionButton(
          onPressed: () {
            final coordinates =
                '${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude}';

            const snackBar = SnackBar(
              content: Text('Coordinates copied!'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            copiedState.copyCoordinates();
            print(coordinates);
          },
          backgroundColor: copiedState.isCopied ? Colors.green : Colors.black87,
          child: copiedState.isCopied
              ? const Icon(Icons.check)
              : const Icon(Icons.copy),
        );
      }),
    );
  }
}

class _CopyCoordinateState extends ChangeNotifier {
  bool _copied = false;

  bool get isCopied => _copied;

  void copyCoordinates() {
    _copied = true;
    notifyListeners();
    Timer(const Duration(seconds: 2), () {
      _copied = false;
      notifyListeners();
    });
  }
}
