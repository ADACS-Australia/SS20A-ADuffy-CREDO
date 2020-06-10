import 'package:sensors/sensors.dart';
import 'dart:async';

class GyroscopeHelper {
  StreamSubscription _streamSubscriptions;

  GyroscopeEvent gyroscopeValues;

  ///should this have a default?
  bool gyroscopeState = false;

  init() {
    _streamSubscriptions = gyroscopeEvents.listen((GyroscopeEvent event) {
      gyroscopeValues = event;
      //print(event);
    });
  }

  toggleGyroscopeValues() {
    //print(gyroscopeState);
    if (gyroscopeState == false) {
      init();
      gyroscopeState = true;

      //return accelerometerValues;
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
