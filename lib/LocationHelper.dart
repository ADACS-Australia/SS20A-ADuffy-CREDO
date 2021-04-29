import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  var location = null;
  var updateTime;
  StreamSubscription<Position>? positionStream;

  init() {
    /// if permission not granted return location == null
    /// else get time stamps and location

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;

    /// forces to use specific android location manager for permission issues.
    /// this should just be ignored bu ios devices

    Future<GeolocationStatus> permission =
        geolocator.checkGeolocationPermissionStatus();

    if (permission == GeolocationStatus.denied) {
      location = null;
    } else {
      var locationOptions =
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

      /// locationOptions controls settings such as the accuracy associated with he location returned

      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) {
        location = position;
        updateTime = DateTime.now();
      });
    }
  }

  /// dispose method for the stream
  void dispose() {
    positionStream?.cancel();
  }
}
