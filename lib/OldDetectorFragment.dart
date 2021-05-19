import 'package:credo_transcript/Frame.dart';
import 'package:credo_transcript/OldCalibrationResult.dart';
import 'package:credo_transcript/models/mockdata.dart';
import 'package:credo_transcript/network/repository.dart';
import 'OldFrameAnalyzer.dart';
import 'OldCalibrationFinder.dart';
import 'package:camera/camera.dart';
import 'OldFrameResult.dart';
import 'Hit.dart';
import 'FileUtils.dart';

var calibrationResult;
var DEFAULT_BLACK_THRESHOLD = 40;
OldCalibrationFinder calibrationFinder = OldCalibrationFinder();

// Get the Repository class to send the hits when detected
CredoRepository _credoRepository = CredoRepository();

// void function that calls on activate camera and starts image stream
// will also need funtionality to connect to server

bool? lastCovered;

Future<dynamic> processImageFrame(
    CameraImage image_processing, int start_frame, var blackThreshold, cameraCoveredChangeCallback) async {
  // uses appv2 for
  start_frame++;

  /// calculate frame values
  OldFrameResult frame_result = new OldFrameResult();
  frame_result.calculateFrame(image_processing, blackThreshold);

  /// check if image is dark enough
  //calibrate_next_frame(avg, max, blacksPercentageSum);
  print(frame_result.max);
  var _isCovered = frame_result.isCovered(
      calibrationResult); //frame_result.isCovered(calibrationResult);

  /// Check if there is a camera covered change event that we need to trigger
  if (lastCovered == null || lastCovered != _isCovered) {
    // Store the result
    lastCovered = _isCovered;

    // Trigger the callback
    if (cameraCoveredChangeCallback != null) {
      cameraCoveredChangeCallback(_isCovered);
    }
  }

  if (_isCovered == true) {
    //isCovered(avg, calibrationResult, blacksPercentage
    ///if calibration has not been run run calibration
    if (calibrationResult == null) {
      calibrationResult = calibrationFinder.calibrateNextFrame(frame_result);
      //print("$calibrationResult");
      var progress = calibrationFinder.counter /
          OldCalibrationFinder.CALIBRATION_LENGHT *
          100;
      print("calibration progress $progress %");
    } else {
      /// convert image-processing into a frame

      Frame frameProcessing = new Frame();
      frameProcessing.byteArray = image_processing; //.planes[0].bytes;

      /// not actually in byte array format !
      frameProcessing.width = image_processing.width;
      frameProcessing.height = image_processing.height;
      frameProcessing.exposureTime =
          0; //TODO this might actually cause issues !!! used to be null
      frameProcessing.imageFormat = 0;
      frameProcessing.timestamp = new DateTime.now();

      Hit? hit = (OldFrameAnalyzer()).checkHit(
          frameProcessing, frame_result, calibrationResult, image_processing);
      //print('$hit');
      if (hit != null) {
        FileUtils.saveToFile(
            hit.toString() + ' ' + frameProcessing.timestamp.toString() + '\n');

        // Send Hit to the server
        await _credoRepository.requestSendHit(hit);

      }
    }
  } else {
    print("not covered");
  }

  return;
}
