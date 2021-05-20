import 'AccelerometerHelper.dart';
import 'CameraHelper.dart';
/// TODO import 'TemperatureHelper.dart' for checking battery temperature (not yet implemented)
import 'GyroscopeHelper.dart';
import 'LocationHelper.dart';

///AllSensorsHelper allows for all relevant sensors to be started and stopped simultaneously
class AllSensorsHelper {
  static final AccelerometerHelper accHelper = AccelerometerHelper();
  static final CameraHelper cameraHelper = CameraHelper();
  static final LocationHelper locationHelper = LocationHelper();
  static final GyroscopeHelper gyroHelper = GyroscopeHelper();

  // Never start running by default
  bool isRunning = false;

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
  /// to ensure there is always data available
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

  toggleAllSensors() {
    isRunning = !isRunning;
    isRunning ? startAllSensors() : stopAllSensors();
  }

  running() {
    return isRunning;
  }
}
