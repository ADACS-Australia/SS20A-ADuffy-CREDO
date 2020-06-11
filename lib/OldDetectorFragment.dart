import 'package:credo_transcript/Frame.dart';
import 'package:credo_transcript/OldCalibrationResult.dart';
import 'OldFrameAnalyzer.dart';
import 'OldCalibrationFinder.dart';
import 'package:camera/camera.dart';
import 'OldFrameResult.dart';

var calibrationResult;
var DEFAULT_BLACK_THRESHOLD = 40;
OldCalibrationFinder calibrationFinder = OldCalibrationFinder();

// void function that calls on activate camera and starts image stream
// will also need funtionality to connect to server
Future<dynamic> processImageFrame(
    CameraImage image_processing, int start_frame, var blackThreshold) async {
  // uses appv2 for
  start_frame++;

  OldFrameResult frame_result = new OldFrameResult();
  frame_result.calculateFrame(image_processing, blackThreshold);

  //calibrate_next_frame(avg, max, blacksPercentageSum);

  var _isCovered = frame_result.isCovered(
      calibrationResult); //frame_result.isCovered(calibrationResult);

  if (_isCovered == true) {
    //isCovered(avg, calibrationResult, blacksPercentage
    if (calibrationResult == null) {
      calibrationResult = calibrationFinder.calibrate_next_frame(frame_result);
      //print("$calibrationResult");
      var progress = calibrationFinder.counter /
          OldCalibrationFinder.CALIBRATION_LENGHT *
          100;
      print("calibration progress $progress %");
    } else {
      /// convert image-processing into a frame

      Frame frameProcessing = new Frame();
      frameProcessing.byteArray = image_processing;
      frameProcessing.width = image_processing.width;
      frameProcessing.height = image_processing.height;
      frameProcessing.exposureTime = null;
      frameProcessing.imageFormat = null;
      frameProcessing.timestamp = new DateTime.now();
      print(frame_result.max);
      print("$calibrationResult");
      var hit = (OldFrameAnalyzer())
          .checkHit(frameProcessing, frame_result, calibrationResult);
    }
  } else {
    print("not covered");
  }

  return;
}
