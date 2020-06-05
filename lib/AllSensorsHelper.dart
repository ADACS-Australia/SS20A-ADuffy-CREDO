import 'AccelerometerHelper.dart';
import 'LocationHelper.dart';
import 'CameraHelper.dart';

//import 'TemperatureHelper.dart';
//import 'GyroscopeHelper.dart';
//import 'OrientationHelper.dart';
///Should this include a try and catch statement?
class AllSensorsHelper {
  AccelerometerHelper accHelper = AccelerometerHelper();
  CameraHelper cameraHelper = CameraHelper();
  LocationHelper locationHelper = LocationHelper();

  startAllSensor() {
    try {
      accHelper.init();
      cameraHelper.init();
      locationHelper.init();
    } catch (e) {
      print(e);
    }
  }

  stopAllSensors() {
    try {
      accHelper.dispose();
      cameraHelper.dispose();
      locationHelper.dispose();
    } catch (e) {
      print(e);
    }
  }
}
