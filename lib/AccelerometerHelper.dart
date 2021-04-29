import 'package:sensors/sensors.dart';
import 'dart:async';

class AccelerometerHelper {
  StreamSubscription? _streamSubscriptions;

  AccelerometerEvent? accelerometerValues;

  bool accelerometerState = false;

  /// initializes the accelerometer stream
  init() {
    _streamSubscriptions =
        accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerValues = event;
    });
  }

  /// toggle accelerometer on and off
  toggleAccelerometerValues() {
    if (accelerometerState == false) {
      init();
      accelerometerState = true;
    } else {
      dispose();
    }
  }

  /// grants access to x,y,z values
  getAccelerometerValues() {
    return accelerometerValues;
  }

  /// ends and disposes of stream
  void dispose() {
    _streamSubscriptions?.cancel();

    accelerometerState = false;
  }
}
