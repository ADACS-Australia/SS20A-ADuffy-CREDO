import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'OldCalibrationResult.dart';
import 'package:camera/camera.dart';

/// The code in this file is a direct adaptation from kotlin-jini.c in the original project code

class OldFrameResult extends BaseFrameResult {
  int avg;
  double blacksPercentage;
  int max;
  int maxIndex;

  calculateFrame(CameraImage image_processing, var blackThreshold) {
    var height = image_processing.height;
    var width = image_processing.width;

    /// Dart automatically works and converts to rgb regardless of operating system.
    /// Each band is stored in a plane the order of planes is  "r g b a"
    /// https://pub.dev/documentation/camera/latest/camera/Plane-class.html
    /// currently we are just passing the red plane through
    /// TODO: check whether only passing the red plane would cause issues
    var planes = image_processing.planes;
    var b = planes[0].bytes; // unit8list
    int size = width * height;

    int sum = 0;
    max = 0;
    maxIndex = 0;
    int blacks = 0;

    for (int i = 0; i < size; ++i) {
      int bb = b[i];
      if (bb > 0) {
        sum += bb;
        if (bb > max) {
          max = bb;
          maxIndex = i;
        }
      }
      if (bb < blackThreshold) {
        ++blacks;
      }
    }

    avg = sum ~/ size;
    blacksPercentage = ((blacks * 10000) / size) / 100;
  }

  @override
  isCovered(BaseCalibrationResult calibrationResult) {
    if (!(calibrationResult is OldCalibrationResult) &&
        (calibrationResult != null)) {
      ///TODO: throw Exception("Screen not covered");
    }

    int statementInput;
    if (calibrationResult is OldCalibrationResult) {
      statementInput = calibrationResult.avg;
    } else {
      statementInput = OldCalibrationResult.DEFAULT_BLACK_THRESHOLD;
    }

    /// kotlin version was split into if statement for readability

    bool result = (avg < statementInput && blacksPercentage >= 99.9);

    return result;
  }
}
