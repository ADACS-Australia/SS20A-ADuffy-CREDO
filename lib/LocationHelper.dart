import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  var location = null;
  var updateTime = 0;
  StreamSubscription<Position> positionStream;

  init() {
    /// if permission not granted return location == null
    /// else get time stamps and location
    ///     if location was null request single location update

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;

    Future<GeolocationStatus> permission =
        geolocator.checkGeolocationPermissionStatus();

    if (permission == GeolocationStatus.denied) {
      location = null;
    } else {
      //geolocator
      //    .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      //    .then((Position position) {
      //  location = position;
      //});

      //var geolocator = Geolocator();
      var locationOptions =
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

      ///problem is on how to turn it off with the rest of the app ??
      ///doe sit need a functiont hat cancels all subscriptions ??
      ///     location, image, accelerometer etc...
      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) {
        location = position;
      });
    }
  }

  void dispose() {
    positionStream.cancel();
  }

//getCurrentLocation() {
// final Geolocator geolocator = Geolocator()
//   ..forceAndroidLocationManager = true;

// geolocator
//     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//     .then((Position position) {
//   //_currentPosition = position;
//   //print(_currentPosition);
//   //});
// }).catchError((e) {
//   print(e);
// });
}
