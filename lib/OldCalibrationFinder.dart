import 'package:credo_transcript/OldCalibrationResult.dart';
import 'package:credo_transcript/OldFrameResult.dart';
import 'package:dartx/dartx.dart';

class OldCalibrationFinder {
  int counter = 0;
  int avgSum = 0;
  int maxSum = 0;
  double blacksPercentageSum = 0;
  static const CALIBRATION_LENGHT = 500;

  calibrateNextFrame(OldFrameResult oldFrameResult) {
    /// inelegant if statement solution to iterate through frames
    /// until counter reaches CALIBRATION_LENGHT.

    counter++;

    if (oldFrameResult.max != null) {
      avgSum += oldFrameResult.avg;
      blacksPercentageSum += oldFrameResult.blacksPercentage;
      maxSum += oldFrameResult.max;
    }

    if (counter >= CALIBRATION_LENGHT) {
      double avg = avgSum / CALIBRATION_LENGHT;
      var blacksPercentage = blacksPercentageSum / CALIBRATION_LENGHT;
      double max_ = maxSum / CALIBRATION_LENGHT;
      var finalAvg = (avg + 20).coerceAtMost(60).coerceAtLeast(10);
      var finalBlack = (avg + 20).coerceAtMost(60).coerceAtLeast(10);

      /// shouldn't finalBlack use blacksPercentage?
      var finalMax = (max_ * 3)
          .coerceAtLeast(80)
          .coerceAtMost(160)
          .coerceAtLeast(finalAvg);

      /// if I am correctly interpreting the kotlin code we should be returning an OldCaibrationResult

      var calibrationResult = new OldCalibrationResult();
      calibrationResult.blackThreshold = finalBlack.toInt();
      calibrationResult.avg = finalAvg.toInt();
      calibrationResult.max = finalMax.toInt();

      return calibrationResult;
    } else {
      return null;
    }
  }
}
