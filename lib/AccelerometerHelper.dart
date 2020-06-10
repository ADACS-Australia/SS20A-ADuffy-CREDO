import 'package:sensors/sensors.dart';
import 'dart:async';

class AccelerometerHelper {
  StreamSubscription _streamSubscriptions;

  AccelerometerEvent accelerometerValues;

  ///should this have a default?
  bool accelerometerState = false;

  init() {
    _streamSubscriptions =
        accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerValues = event;
      //print(event);
    });
  }

  toggleAccelerometerValues() {
    //print(accelerometerState);
    if (accelerometerState == false) {
      init();
      accelerometerState = true;

      //return accelerometerValues;
    } else {
      dispose();
    }
  }

  getAccelerometerValues() {
    return accelerometerValues;
  }

  void dispose() {
    _streamSubscriptions.cancel();

    accelerometerState = false;
  }
}
