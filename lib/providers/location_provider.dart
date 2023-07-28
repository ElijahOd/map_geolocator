import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;

  bool get isTracking => _positionStreamSubscription != null;

  void startTracking() {
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((position) {
      _currentPosition = position;
      notifyListeners();
    });
  }

  void stopTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    _currentPosition = null;
    notifyListeners();
  }

  Position? get currentPosition => _currentPosition;
}
