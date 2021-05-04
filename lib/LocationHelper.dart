import 'dart:async';

import 'package:geolocator/geolocator.dart';

///TODO: needs to replace errors thrown with returning location=null ??

class LocationHelper {
  var location;
  var updateTime;
  StreamSubscription<Position>? positionStream;

  init() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // stream goes here and 'location =' is defined

    positionStream = Geolocator.getPositionStream().listen((Position position) {
      location = position;
      updateTime = DateTime.now();
    });
  }

// dispose method for the stream
  void dispose() {
    positionStream?.cancel();
  }

//StreamSubscription<Position>? positionStream;
//
//init() {
//  /// if permission not granted return location == null
//  /// else get time stamps and location
//
//  final Geolocator geolocator = Geolocator()
//    ..forceAndroidLocationManager = true;
//
//  /// forces to use specific android location manager for permission issues.
//  /// this should just be ignored bu ios devices
//
//  Future<GeolocationStatus> permission =
//      geolocator.checkGeolocationPermissionStatus();
//
//  if (permission == GeolocationStatus.denied) {
//    location = null;
//  } else {
//    var locationOptions =
//        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
//
//    /// locationOptions controls settings such as the accuracy associated with he location returned
//
//    positionStream = geolocator
//        .getPositionStream(locationOptions)
//        .listen((Position position) {
//      location = position;
//      updateTime = DateTime.now();
//    });
//  }
//}
//
///// dispose method for the stream
//void dispose() {
//  positionStream?.cancel();
//}
}
