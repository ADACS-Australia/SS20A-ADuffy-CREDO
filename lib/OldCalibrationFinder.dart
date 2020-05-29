import 'package:credo_transcript/OldFrameResult.dart';
import 'package:dartx/dartx.dart';

class OldCalibrationFinder {
  int counter = 0;
  double avgSum = 0;
  double maxSum = 0;
  double blacksPercentageSum = 0;
  static const CALIBRATION_LENGHT = 500;

  calibrate_next_frame(OldFrameResult oldFrameResult) {
    avgSum += oldFrameResult.avg;
    blacksPercentageSum += oldFrameResult.blacksPercentage;
    maxSum += oldFrameResult.max;
    counter++;

    if (counter >= CALIBRATION_LENGHT) {
      double avg = avgSum / CALIBRATION_LENGHT;
      var blacksPercentage = blacksPercentageSum / CALIBRATION_LENGHT;
      double max_ = maxSum / CALIBRATION_LENGHT;
      var finalAvg = (avg + 20).coerceAtMost(60).coerceAtLeast(10);
      var finalBlack = (avg + 20)
          .coerceAtMost(60)
          .coerceAtLeast(10); // shouldn't that be blackspercentage?
      var finalMax = (max_ * 3)
          .coerceAtLeast(80)
          .coerceAtMost(160)
          .coerceAtLeast(finalAvg);

      //OldCalibrationResult(
      //finalBlack.toInt(), finalAvg.toInt(), finalMax.toInt());
    } else {
      return null;
    }
  }
}
