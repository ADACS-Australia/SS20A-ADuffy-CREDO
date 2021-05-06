import 'package:flutter/material.dart';

import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'OldCalibrationResult.dart';
import 'package:camera/camera.dart';
import 'package:stats/stats.dart';

/// The code in this file is a direct adaptation from kotlin-jini.c in the original project code

class OldFrameResult extends BaseFrameResult {
  late int avg;
  late double blacksPercentage;
  late int max;
  late int maxIndex;

  calculateFrame(CameraImage imageProcessing, var blackThreshold) {
    // unit8list - and we only care about the Y plane which is plane 0
    //print("${imageProcessing.height}, ${imageProcessing.width}");

    // 35 for android, 1111970369 for ios (may vary with phone!!)
    print('Raw format: ${imageProcessing.format.raw}');

    var data = imageProcessing.planes[0].bytes;
    print('number of planes');
    print(imageProcessing.planes.length);

    int sum = 0;
    max = 0;
    maxIndex = 0;
    int blacks = 0;

    // code for the ios image format
    const int FOURCC_BGRA = 1111970369;

    int pixelCount = data.length;
    int pixelStride = 1;
    // checks if the format conforms with ios and if so change step sizes to only get one plane
    if (imageProcessing.format.raw == FOURCC_BGRA) {
      pixelCount ~/= 4;
      pixelStride = 4;
    }

    for (int i = 0; i < data.length; i += pixelStride) {
      var bb = data[i].toUnsigned(8);
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

    avg = sum ~/ pixelCount;
    blacksPercentage = ((blacks * 10000) / pixelCount) / 100;
    var percentage = (blacks / pixelCount) * 100;
    print(blacksPercentage);
    print(percentage);
  }

  @override
  isCovered(BaseCalibrationResult calibrationResult) {
    if (!(calibrationResult is OldCalibrationResult) &&
        (calibrationResult != null)) {
      ///TODO: throw Exception("Screen not covered");
    }

    int statementInput;
    if (calibrationResult is OldCalibrationResult) {
      statementInput = calibrationResult.avg;
    } else {
      statementInput = OldCalibrationResult.DEFAULT_BLACK_THRESHOLD;
    }

    /// kotlin version was split into if statement for readability

    bool result = (avg < statementInput && blacksPercentage >= 99.9);

    return result;
  }
}
