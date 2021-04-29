import 'package:credo_transcript/Camera2FrameResult.dart';
import 'RawFormatCalibrationResult.dart';
import 'AllSensorsHelper.dart';
import 'package:stats/stats.dart';

class RawFormatCalibrationFinder {
  // leaving out all the on callback stuff for now

  var clusterFactorWidth = 2;
  var clusterFactorHeight = 2;
  var counter = 0;
  var maxValues =
      <int>[]; // unlike the original lists are not of a specific size
  var avgs = <int>[];
  var LENGTH = 10;
  // 60000; // TODO get a real value that incorporates the exposure time of the image in mils

  // skipping start and trynext functions for now

  var ignoreFirstsFrame = 0;
  onFrameRecieved(Camera2FrameResult frameResult) {
    // if (ignoreFirstsFrame < 3) {
    //  ignoreFirstsFrame++;
    //}

    // arbitrary waiting process imposed so frames don't get skipped presumably
    // at this stage out code already has a frame result and it does not need to be recalculated
    while (true) {
      if (frameResult.avg <=
          RawFormatCalibrationResult.DEFAULT_NOISE_THRESHOLD) {
        if (counter >= LENGTH) {
          continue;
        }
        print("======================calibration max = ${frameResult.max}");
        maxValues[counter] = frameResult.max;
        avgs[counter] = frameResult.avg;
        counter++;

        if (counter == LENGTH) {
          print(">>>>>>>> c progress: $LENGTH");
          counter = 0;

          AllSensorsHelper().stopAllSensors();
          //cameraUtil.stop() // This will stop the process of recording images with the camera
          // techincally should be linked to the same sensor helper as in main but should still work?

          var stat = Stats.fromData(maxValues);
          print("======${clusterFactorWidth}x$clusterFactorHeight stdDev : " +
              stat.standardDeviation.toString());

          /// I have no wy of checking configuration or image format
          /// i don't see how the wrong image type could be piped here
          /// if more options for different types are to be added we need to work on configuations
          //if (configuration.imageFormat == ImageFormat.RAW_SENSOR) is not implemented as only RAWs should be passed to this in the first place
          if (stat.standardDeviation < 2) {
            //callback.onCalibrationSuccess is not implemented in this version
            var rawCalibrationResults = RawFormatCalibrationResult();
            rawCalibrationResults.clusterFactorWidth = clusterFactorWidth;
            rawCalibrationResults.clusterFactorHeight = clusterFactorHeight;
            rawCalibrationResults.detectionThreshold =
                (stat.average * rawCalibrationResults.AMPLIFIER).toInt();
            rawCalibrationResults.calibrationNoise = Stats.fromData(avgs).max;
          } else {
            changeClusterFactors(frameResult);
          }
          // there are a number of other else statements we have skipped in this code as it is not applicable to this
          // codebase at this point in time. refer to original should it become necessary.
        }
      } else {
        print('not covered');
        // TODO look into states and return states used in original code
      }
    }
  }

  /// The function should create everything for the calibration results.

  changeClusterFactors(Camera2FrameResult frameResult) {
    // As we have no configuration settings configuration.width and .height are replaced by frameResult original width and height

    if (clusterFactorWidth <= clusterFactorHeight) {
      clusterFactorWidth =
          findNextDivisor(frameResult.originalWidth, clusterFactorWidth);
    } else {
      clusterFactorHeight =
          findNextDivisor(frameResult.originalHeight, clusterFactorHeight);
    }
  }

  // iterate through numbers from initial divisor until initial number is reached
  int findNextDivisor(int number, int currentDivisor) {
    var remainder;
    var counter = 0;
    while ((currentDivisor + counter) < number) {
      // should be <=?
      counter++;
      remainder = number % (currentDivisor + counter);
      if (remainder == 0) {
        return (currentDivisor + counter); // should then quit out of the loop
      }
    }
    return 0;
  }
}
