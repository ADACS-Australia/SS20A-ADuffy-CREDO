/// Camera2 is aimed at more modern apis that come with with
/// added features in regard to noise removal in images that make detecting hits more difficult
/// therefore the Raw image frames need to be accessed

import 'package:camera/camera.dart';
import 'Frame.dart';

Future<dynamic> processImageFrame(CameraImage image_processing,
    var processingMethod, var blackThreshold) async {
  // should Frame be passed in rather then CameraImage as in the original code??

  var frameResult;

  switch (processingMethod) {
    case 'official':
      {
        // statements;
      }
      break;

    case 'experimental':
      {
        //statements;
      }
      break;

    default:
      {
        //statements;
      }
      break;
  }

  //var _isCovered = frameResult.isCovered(
  //    calibrationResult); //frameResult.isCovered(calibrationResult);
//
  //if (_isCovered == true) {
  //  //isCovered(avg, calibrationResult, blacksPercentage
  //  if (calibrationResult == null) {
  //    calibrationResult = calibrationFinder.calibrateNextFrame(frameResult);
  //    //print("$calibrationResult");
  //    var progress = calibrationFinder.counter /
  //        OldCalibrationFinder.CALIBRATION_LENGHT *
  //        100;
  //    print("calibration progress $progress %");
  //  } else {
  //    /// convert image-processing into a frame
//
  //    Frame frameProcessing = new Frame();
  //    frameProcessing.byteArray = image_processing; //.planes[0].bytes;
//
  //    /// not actually in byte array format !
  //    frameProcessing.width = image_processing.width;
  //    frameProcessing.height = image_processing.height;
  //    frameProcessing.exposureTime = null;
  //    frameProcessing.imageFormat = null;
  //    frameProcessing.timestamp = new DateTime.now();
//
  //   // Hit hit = (OldFrameAnalyzer())
  //       // .checkHit(frameProcessing, frame_result, calibrationResult);
  //    //print('$hit');
  //    if (hit != null) {
  //      //FileUtils.saveToFile(
  //       //   hit.toString() + ' ' + frameProcessing.timestamp.toString() + '\n');
  //    }
  //  }
  //} else {
  //  print("not covered");
  //}
}