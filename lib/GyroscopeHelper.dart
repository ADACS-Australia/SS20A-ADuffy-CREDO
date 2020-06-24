import 'package:sensors/sensors.dart';
import 'dart:async';

/// class for initializing, stopping a gyroscope stream and querying its values

class GyroscopeHelper {
  StreamSubscription _streamSubscriptions;

  GyroscopeEvent gyroscopeValues;

  bool gyroscopeState = false;

  init() {
    _streamSubscriptions = gyroscopeEvents.listen((GyroscopeEvent event) {
      gyroscopeValues = event;
    });
  }

  toggleGyroscopeValues() {
    if (gyroscopeState == false) {
      init();
      gyroscopeState = true;
    } else {
      dispose();
    }
  }

  getGyroscopeValues() {
    return gyroscopeValues;
  }

  void dispose() {
    _streamSubscriptions.cancel();

    gyroscopeState = false;
  }
}
