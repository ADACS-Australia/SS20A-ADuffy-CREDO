import 'package:dartx/dartx.dart';

const CALIBRATION_LENGHT = 500;

var counter = 0;

calibrate_next_frame(avgSum, maxSum, blacksPercentageSum) {
  counter++;
  //print(0.5.coerceAtMost(5).coerceAtLeast(1));

  var results = [];
  if (counter >= CALIBRATION_LENGHT) {
    double avg = avgSum / CALIBRATION_LENGHT;
    var blacksPercentage = blacksPercentageSum / CALIBRATION_LENGHT;
    double max_ = maxSum / CALIBRATION_LENGHT;
    var finalAvg = (avg + 20).coerceAtMost(60).coerceAtLeast(10);
    var finalBlack = (avg + 20)
        .coerceAtMost(60)
        .coerceAtLeast(10); // shouldn't that be blackspercentage?
    var finalMax =
        (max_ * 3).coerceAtLeast(80).coerceAtMost(160).coerceAtLeast(finalAvg);

    results = [finalAvg, finalBlack, finalMax];
  } else {
    results = [null];
  }
  return results;
}
