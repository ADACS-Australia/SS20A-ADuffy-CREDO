import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'OldCalibrationResult.dart';
import 'package:camera/camera.dart';

class OldFrameResult extends BaseFrameResult {
  int avg;
  double blacksPercentage;
  int max;
  int maxIndex;

  calculateFrame(CameraImage image_processing, var blackThreshold) {
    var height = image_processing.height;
    var width = image_processing.width;
    // order is r g b a
    var planes = image_processing.planes;
    var b = planes[0].bytes; // unit8list
    int size = width * height;

    int sum = 0;
    int max = 0;
    int maxIndex = 0;
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
    print(blacksPercentage);
  }

  @override
  isCovered(BaseCalibrationResult calibrationResult) {
    if (!(calibrationResult is OldCalibrationResult) &&
        (calibrationResult != null)) {
      ///TO DO: throw Exception("Screen not covered");
    }

    int statementInput;
    if (calibrationResult is OldCalibrationResult) {
      statementInput = calibrationResult.avg;
    } else {
      statementInput = OldCalibrationResult.DEFAULT_BLACK_THRESHOLD;
    }

    /// kotlin version was split into if statement for readability
    //statementInput = (calibrationResult as OldCalibrationResult)?.avg ??
    //    OldCalibrationResult.DEFAULT_BLACK_THRESHOLD;

    bool result = (avg < statementInput && blacksPercentage >= 99.9);

    //print("$result");
    return result;
    //////////////////
    //if ((calibrationResult is OldCalibrationResult) ) {
    //  var statementInput =
    //      calibrationResult.avg ?? calibrationResult.DEFAULT_BLACK_THRESHOLD;
    //  bool result = (avg < statementInput && blacksPercentage >= 99.9);
//
    //  print("$result");
    //  return result;
    //}
    //
    //else {
    //  print(calibrationResult.runtimeType);
//
    //  //return true; //TO DO: take out this return statement
    //  //throw Exception("Screen not covered");
    //}
  }
}
