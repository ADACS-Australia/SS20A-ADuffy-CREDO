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
import 'YUVToRGBConverter.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as Img;

class RawFormatFrameAnalyzer extends BaseFrameAnalyzer {
  YUVToRGBConverter colourConverter;
  @override

  /// checkHit checks if hit conditions are met and then egts the data ready to be send
  /// becasue of the yuv to rgb conversion we need to pass it the original image.
  /// image could potentially replace frame all together but we kept frame from the original code
  Hit checkHit(Frame frame, BaseFrameResult frameResult,
      BaseCalibrationResult calibration, CameraImage image) {
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

      // converts to RGB and into an image from the image.dart library to encode into png
      Img.Image bitmap = colourConverter.convertYUV420toImageColor(image);

      var scaledWidth = frame.width / _calibration.clusterFactorWidth;
      var x = _frameResult.maxIndex % scaledWidth;
      int y = _frameResult.maxIndex ~/
          scaledWidth; // changed to int for later operations

      var croppedSize = 70;
      var startRow =
          (y * _calibration.clusterFactorHeight) - (croppedSize ~/ 2);
      var startColumn = (x.toInt() * _calibration.clusterFactorWidth) -
          (croppedSize ~/ 2); // changed x to int so that start column is an int
      /// startRow and start colum need to be integers
      /// changed x and y to be integers rather then rounding at a later point in time
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

      Img.Image croppedImage = Img.copyCrop(
          bitmap,
          startColumn,
          startRow,
          bitmap.width,
          bitmap.height); //cropping the image to startRow and Start Column size
      // TODO check that the image gets cropped correctly as there is no documentation on the function
      var imagePng = Img.encodePng(croppedImage);
      var dataString = imagePng.toString();

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
