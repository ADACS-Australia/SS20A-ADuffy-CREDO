import 'dart:typed_data';
import 'package:credo_transcript/OldCalibrationResult.dart';

import 'OldCalibrationFinder.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'OldFrameResult.dart';
import 'package:sensors/sensors.dart';

var calibrationResult = null;
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

  //PLACEHOLDER for testing remove once done
  OldCalibrationResult _notCovered = new OldCalibrationResult();
  _notCovered.avg = 15;
  _notCovered.blackThreshhold = 99;
  _notCovered.max = 30;
// remove above

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
      print('checking for hits');
    }
  } else {
    print("not covered");
  }

  return;
}
