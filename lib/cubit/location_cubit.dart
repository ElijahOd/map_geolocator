import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<Position?> {
  LocationCubit() : super(null);

  StreamSubscription<Position>? _positionStreamSubscription;

  bool get isTracking => _positionStreamSubscription != null;

  void startTracking() {
    _positionStreamSubscription ??= Geolocator.getPositionStream().listen(
      (Position position) {
        emit(position);
      },
    );
  }

  void stopTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    emit(null);
  }

  Position? get currentPosition => state;
  double? get latitude => currentPosition?.latitude;
  double? get longitude => currentPosition?.longitude;
  double? get altitude => currentPosition?.altitude;
  double? get speed => currentPosition?.speed;
  double? get accuracy => currentPosition?.accuracy;
}
