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

  calculateFrame(CameraImage imageProcessing, var blackThreshold) {
    // unit8list - and we only care about the Y plane which is plane 0
    var data = imageProcessing.planes[0].bytes;

    int sum = 0;
    max = 0;
    maxIndex = 0;
    int blacks = 0;

    for (int i = 0; i < data.length; i++) {
      var bb = data[i].toUnsigned(8);
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

    avg = sum ~/ data.length;
    blacksPercentage = ((blacks * 10000) / data.length) / 100;
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
