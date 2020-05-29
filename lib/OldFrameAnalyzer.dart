import 'BaseFrameAnalyzer.dart';
import 'Frame.dart';
import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'Hit.dart';
import 'dart:math';
import 'OldFrameResult.dart';
import 'OldCalibrationResult.dart';
import 'package:image/image.dart';

BaseFrameAnalyzer OldFrameAnalyzer() {
  const HIT_BITMAP_SIZE = 60;

  @override
  Hit checkHit(Frame frame, BaseFrameResult frameResult,
      BaseCalibrationResult calibration) {
    OldFrameResult _frameResult = frameResult;
    OldCalibrationResult _calibration = calibration;
    var _max = _calibration.max;

    Image image;

    if (_frameResult.max > _max) {
      var margin = HIT_BITMAP_SIZE / 2;
      int centerX =
          _frameResult.maxIndex % frame.width; // % calculates the remainder
      int centerY = _frameResult.maxIndex ~/
          frame.width; // ~ always returns non fration value

      var offsetX = max(0, centerX - margin);
      var offsetY = max(0, centerY - margin);
      var endX = min(frame.width, centerX + margin);
      var endY = min(frame.height, centerY + margin);

      // TO DO: make image from stream into png here but may have to be moved

      var dataString = encodePng(image);

      /// make to string for sending

      var hit = Hit();
      hit.frameContent = dataString;
      hit.timestamp = frame.timestamp;
      //hit.latitude = LocationHelper.location?.latitude
      //hit.longitude = LocationHelper.location?.longitude
      //hit.altitude = LocationHelper.location?.altitude
      //hit.accuracy = LocationHelper.location?.accuracy
      //hit.provider = LocationHelper.location?.provider
      hit.width = frame.width;
      hit.height = frame.height;
      hit.x = centerX;
      hit.y = centerY;
      hit.maxValue = _frameResult.max;
    }
  }
// should already be in rgb
}
