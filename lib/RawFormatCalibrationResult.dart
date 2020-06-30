import 'package:credo_transcript/BaseCalibrationResult.dart';
import 'dart:collection';

class RawFormatCalibrationResult extends BaseCalibrationResult {
  int clusterFactorWidth;
  int clusterFactorHeight;
  int detectionThreshold;
  int calibrationNoise;

  static const AMPLIFIER = 1.10;
  static const DEFAULT_NOISE_THRESHOLD = 10; // const vs final ?

  // threshholdQueue --> static list TODO look up static lists
  var thresholdQueue =
      Queue(); // is a linkedList in the original code but dart complains
  // did not make it a double linked queue as you only add to the front and remove from the back so queue is sufficient

  adjustThreshold(int max) {
    thresholdQueue.addFirst((max * AMPLIFIER).toInt());
    print("=====adjust threshold ${thresholdQueue.length} ");

    if (thresholdQueue.length > 20) {
      thresholdQueue.removeLast();
      detectionThreshold =
          thresholdQueue.toList().reduce((value, element) => value + element) /
              thresholdQueue.length; //neatest way to get the mean
    }
  }

  @override
  save() {
    // TODO: implement save
    throw UnimplementedError();
  }
}
