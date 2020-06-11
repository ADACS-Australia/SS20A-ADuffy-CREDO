import 'AccelerometerHelper.dart';
import 'LocationHelper.dart';
import 'CameraHelper.dart';

//import 'TemperatureHelper.dart'; // can't get ambient temperature
import 'GyroscopeHelper.dart';

//import 'OrientationHelper.dart'; // not needed as not used
///Should this include a try and catch statement?
class AllSensorsHelper {
  static final AccelerometerHelper accHelper = AccelerometerHelper();
  static final CameraHelper cameraHelper = CameraHelper();
  static final LocationHelper locationHelper = LocationHelper();
  static final GyroscopeHelper gyroHelper = GyroscopeHelper();

  startAllSensors() {
    try {
      locationHelper.init();
      accHelper.init();
      gyroHelper.init();
      cameraHelper.init();
    } catch (e) {
      print(e);
    }
  }

  /// I am starting the camera helper last but stopping it first
  /// to ensure there is always data availible
  /// for any incoming images
  stopAllSensors() {
    try {
      cameraHelper.dispose();
      accHelper.dispose();
      gyroHelper.dispose();
      locationHelper.dispose();
    } catch (e) {
      print(e);
    }
  }
}
