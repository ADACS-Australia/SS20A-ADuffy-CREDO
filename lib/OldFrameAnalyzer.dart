import 'package:credo_transcript/AllSensorsHelper.dart';

import 'BaseFrameAnalyzer.dart';
import 'Frame.dart';
import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'Hit.dart';
import 'dart:math';
import 'OldFrameResult.dart';
import 'OldCalibrationResult.dart';
import 'package:image/image.dart';
import 'main.dart';
import 'package:sensors/sensors.dart';

class OldFrameAnalyzer extends BaseFrameAnalyzer {
  final HIT_BITMAP_SIZE = 60;

  @override
  Hit checkHit(Frame frame, BaseFrameResult frameResult,
      BaseCalibrationResult calibration) {
    OldFrameResult _frameResult = frameResult;
    OldCalibrationResult _calibration = calibration;
    var _max = _calibration.max;

    Image image;

    /// conditionals to qualify as a hit
    if (_frameResult.max > _max) {
      var margin = HIT_BITMAP_SIZE / 2;
      int centerX =
          _frameResult.maxIndex % frame.width; // % calculates the remainder
      int centerY = _frameResult.maxIndex ~/
          frame.width; // ~ always returns non fraction value

      var offsetX = max(0, centerX - margin);
      var offsetY = max(0, centerY - margin);
      var endX = min(frame.width, centerX + margin);
      var endY = min(frame.height, centerY + margin);

      /// make to string for sending
      var dataPng = encodePng(image);
      var dataString = dataPng.toString();

      var hit = Hit();
      hit.frameContent = dataString;
      hit.timestamp = frame.timestamp;
      hit.latitude = AllSensorsHelper.locationHelper.location?.latitude;
      hit.longitude = AllSensorsHelper.locationHelper.location?.longitude;
      hit.altitude = AllSensorsHelper.locationHelper.location?.altitude;
      hit.accuracy = AllSensorsHelper.locationHelper.location?.accuracy;

      /// dart does not return the equivalent of the original LocationHelper.location?.provider
      //hit.provider = LocationHelper.location?.provider
      hit.width = frame.width;
      hit.height = frame.height;
      hit.x = centerX;
      hit.y = centerY;
      hit.maxValue = _frameResult.max;

      if (calibration is OldCalibrationResult) {
        hit.blackThreshold = _calibration.blackThreshold;
      }
      hit.average = _frameResult.avg.toDouble();
      hit.blacksPercentage = _frameResult.blacksPercentage;
      hit.ax = AllSensorsHelper.accHelper.accelerometerValues.x;
      hit.ay = AllSensorsHelper.accHelper.accelerometerValues.y;
      hit.az = AllSensorsHelper.accHelper.accelerometerValues.z;
      hit.temperature = null;

      /// ambient temp too hardware dependant maybe the battery package does have a temp measurement ?
      /// TODO check battery package to get temperature
      print('found a hit');
      print(DateTime.now());
      return hit;
    } else {
      return null;
    }
  }
// should already be in rgb
}
