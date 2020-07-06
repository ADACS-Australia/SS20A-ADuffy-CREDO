import 'dart:html';

import 'package:credo_transcript/BaseFrameAnalyzer.dart';
import 'package:credo_transcript/Camera2FrameResult.dart';
import 'Hit.dart';
import 'Frame.dart';
import 'BaseCalibrationResult.dart';
import 'BaseFrameResult.dart';
import 'package:credo_transcript/RawFormatCalibrationResult.dart';
import 'OldFrameAnalyzer.dart';
import 'dart:math';
import 'AllSensorsHelper.dart';
import 'OldCalibrationResult.dart';

class RawFormatFrameAnalyzer extends BaseFrameAnalyzer {
  @override
  Hit checkHit(Frame frame, BaseFrameResult frameResult,
      BaseCalibrationResult calibration) {
    Camera2FrameResult _frameResult = frameResult;
    RawFormatCalibrationResult _calibration = calibration;
    var maxValue = _calibration.detectionThreshold;

    print(
        "=============================== check hit ${_frameResult.max}   $max");
    if (_frameResult.max > maxValue) {
      var margin = OldFrameAnalyzer.HIT_BITMAP_SIZE /
          2; // because static const can't call it --> try final
      int centerX = _frameResult.maxIndex.remainder(frame.width);
      int centerY =
          _frameResult.maxIndex ~/ frame.width; // do these need to be ints ??

      var offsetX = max(0.0, centerX - margin);
      var offsetY = max(0.0, centerY - margin);
      var endX = min(frame.width, centerX + margin);
      var endY = min(frame.height, centerY + margin);

      var bitmap = ImageBitmap; //TODO fix bitmap

      var scaledWidth = frame.width / _calibration.clusterFactorWidth;
      var x = _frameResult.maxIndex % scaledWidth;
      var y = _frameResult.maxIndex / scaledWidth;

      var croppedSize = 70;
      var startRow = (y * _calibration.clusterFactorHeight) - (croppedSize / 2);
      var startColumn = (x * _calibration.clusterFactorWidth) -
          (croppedSize / 2); // do these need to be ints ?

      if (startColumn + croppedSize > bitmap.width) {
        startColumn = bitmap.width - croppedSize;
      }
      if (startColumn < 0) {
        startColumn = 0;
      }
      if (startRow + croppedSize > bitmap.height) {
        startRow = bitmap.height - croppedSize;
      }
      if (startRow < 0) {
        startRow = 0;
      }

// TODO fix bitmap to png
      //val cropDataPNG = bitmap2png(croppedBitmap)
      //val dataString = Base64.encodeToString(cropDataPNG, Base64.DEFAULT)

      var hit = Hit();
      hit.frameContent = dataString;
      hit.timestamp = frame.timestamp;
      hit.latitude = //LocationHelper.location?.latitude;
          hit.latitude = AllSensorsHelper.locationHelper.location?.latitude;
      hit.longitude = AllSensorsHelper.locationHelper.location?.longitude;
      hit.altitude = AllSensorsHelper.locationHelper.location?.altitude;
      hit.accuracy = AllSensorsHelper.locationHelper.location?.accuracy;
      //hit.provider = //LocationHelper.location?.provider;
      hit.width = frame.width;
      hit.height = frame.height;
      hit.x = centerX;
      hit.y = centerY;
      hit.maxValue = _frameResult.max;
      //if (_calibration is OldCalibrationResult) {
      //  hit.blackThreshold =
      //      _calibration.blackThreshold; // why won't that work?
      //}
      hit.average = _frameResult.avg.toDouble();
      // hit.blacksPercentage = _frameResult.blacksPercentage;
      hit.ax = AllSensorsHelper.accHelper.accelerometerValues.x;
      hit.ay = AllSensorsHelper.accHelper.accelerometerValues.y;
      hit.az = AllSensorsHelper.accHelper.accelerometerValues.z;
      hit.temperature = null;

      return hit;
    }
    _calibration.adjustThreshold(_frameResult.max);
    return null;
  }
}
