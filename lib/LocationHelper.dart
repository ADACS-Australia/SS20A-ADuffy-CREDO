import 'package:geolocator/geolocator.dart';

class LocationHelper {
  var location = null;
  var updateTime = 0;
  init() {
    /// if permission not granted return location == null
    /// else get time stamps and location
    ///     if location was null request single location update

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;

    Future<GeolocationStatus> permission =
        geolocator.checkGeolocationPermissionStatus();

    if (permission == GeolocationStatus.denied) {}
  }

  @override
  onLocationChanged(location, locationtime) {
    ///why doesn't it complain about location.time
    if (location != null) {
      if (location.time > updateTime) {
        updateTime = location.time;
        //this@LocationHelper.location = location
      }
    }
  }
}

_getCurrentLocation() {
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager = true;

  geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
    //setState(() {
    //_currentPosition = position;
    //print(_currentPosition);
    //});
  }).catchError((e) {
    print(e);
  });
}
