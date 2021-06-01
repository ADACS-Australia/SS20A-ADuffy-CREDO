import 'AccelerometerHelper.dart';
import 'CameraHelper.dart';
import 'GyroscopeHelper.dart';
import 'LocationHelper.dart';
import 'main.dart';

/// TODO import 'TemperatureHelper.dart' for checking battery temperature (not yet implemented)

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

    if (isRunning) {
      // Start the detector
      startAllSensors();

      // Set the detector start time if the detector is running
      globals.detectorStartTime = DateTime.now();

      // Set the hit count back to 0
      globals.detectorHits = 0;
    } else {
      // Stop the detector
      stopAllSensors();
    }
  }

  running() {
    return isRunning;
  }
}
