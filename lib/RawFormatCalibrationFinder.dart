import 'package:credo_transcript/Camera2FrameResult.dart';
import 'package:camera/camera.dart';
import 'Frame.dart';
import 'RawFormatCalibrationResult.dart';

class RawFormatCalibrationFinder {
  // leaving out all the on callback stuff for now

  var clusterFactorWidth = 2;
  var clusterFactorHeight = 2;
  var counter = 0;
  var max = List<int>(); // unlike the original lists are not of a specific size
  var avgs = List<int>();
  var LENGHT =
      60000; // TODO get a real value that incorperates the exposure time of the image in mils

  // skipping start and trynext functions for now

  var ignoreFirstsFrame = 0;
  onFrameRecieved(Camera2FrameResult frameResult) {
    if (ignoreFirstsFrame < 3) {
      ignoreFirstsFrame++;
    }

    if (frameResult.avg <= RawFormatCalibrationResult.DEFAULT_NOISE_THRESHOLD) {
// TODO what does the return @launch do and do i copy those if statements of skip them ?
      //if (counter >= LENGTH) {
      // return null;
      //}
      print("======================calibration max = ${frameResult.max}");
      max[counter] = frameResult.max;
      avgs[counter] = frameResult.avg;
      counter++;
    }
  }
}
