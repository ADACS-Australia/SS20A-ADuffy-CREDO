import 'dart:typed_data';
import 'OldCalibrationFinder.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';

var calibrationResult = null;
var DEFAULT_BLACK_THRESHOLD = 40;

// void function that calls on activate camera and starts image stream
// will also need funtionality to connect to server
Future<dynamic> processImageFrame(
    CameraImage image_processing, int start_frame, var blackThreshold) async {
  // uses appv2 for
  start_frame++;

  var height = image_processing.height;
  var width = image_processing.width;
  // order is r g b a
  var planes = image_processing.planes;
  var b = planes[0].bytes; // unit8list
  int size = width * height;
  //jbyte *b = (*env)->GetByteArrayElements(env, bytes, JNI_FALSE);
  //jbyte *address = b;
  int sum = 0;
  int max = 0;
  int maxIndex = 0;
  int blacks = 0;
  for (int i = 0; i < size; ++i) {
    int bb = b[i];
    //bb = bb & 0xff; // no longer needed as the is already a unit 8 list and won't allow input bigger then 255
    if (bb > 0) {
      sum += bb;
      if (bb > max) {
        max = bb;
        maxIndex = i;
      }
    }
    if (bb < blackThreshold) {
      ++blacks;
    }
  }
  // needs to format and return values for assertaining a hit
  //print('$height,$width');
  //var returns = [sum / size, blacks, size, max, maxIndex];

  var avg = sum / size;
  var blacksPercentage = ((blacks * 10000) / size) / 100;
  // changes made so it now goes straight to calibration
  // calls calibration function

  //calibrate_next_frame(avg, max, blacksPercentageSum);
  var _isCovered = isCovered(avg, calibrationResult, blacksPercentage);

  if (isCovered(35, null, 99.9) == true) {
    //isCovered(avg, calibrationResult, blacksPercentage
    if (calibrationResult == null) {
      calibrationResult = calibrate_next_frame(avg, max, blacksPercentage)[0];
      print("$calibrationResult");
      var progress = counter.toDouble() / CALIBRATION_LENGHT * 100;
      print("calibration progress $progress %");
    } else {
      print('checking for hits');
      //var hit = checkHit()
    }
  } else {
    print("not covered");
  }

  return;
}

testing() {
  List<int> input = [111, 232, 135, 134, 95, 186, 157, 98, 139];
  var size = 9;
  var b = Uint8List.fromList(input);
  int sum = 0;
  int max = 0;
  int maxIndex = 0;
  int blacks = 0;
  for (int i = 0; i < size; ++i) {
    int bb = b[i];
    print('$bb');
    //bb = bb & 0xff; // no longer needed as the is already a unit 8 list and won't allow input bigger then 255
    if (bb > 0) {
      sum += bb;
      print('$sum');
      if (bb > max) {
        max = bb;
        maxIndex = i;
      }
    }
  }
  //var returns = [sum / size, blacks, size, max, maxIndex]; // what kotlin.c used to return

  var avg = sum / size;
  var blacksPercentage = ((blacks * 10000) / size) / 100;
  // changes made so it now goes straight to calibration
  // calls calibration function

  //calibrate_next_frame(avg, max, blacksPercentageSum);
  var _isCovered = isCovered(avg, calibrationResult, blacksPercentage);

  if (isCovered(35, null, 99.9) == true) {
    //isCovered(avg, calibrationResult, blacksPercentage
    if (calibrationResult == null) {
      var calibrationResult =
          calibrate_next_frame(avg, max, blacksPercentage)[0];
      print("$calibrationResult");
      var progress = counter.toDouble() / CALIBRATION_LENGHT * 100;
      print("calibration progress $progress %");
    } else {
      print('checking for hits');
      //var hit = checkHit()
    }
  } else {
    print("not covered");
  }
  return;
}

isCovered(frame_avg, calibrationResultAvg, blacksPercentage) {
  var statement_input = calibrationResultAvg ?? DEFAULT_BLACK_THRESHOLD;
  if (frame_avg < statement_input && blacksPercentage >= 99.9) {
    print("TRUE ... is covered");
    return true;
  } else {
    print("FALSE");
    return false;
  }
}
