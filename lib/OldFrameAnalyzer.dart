import 'BaseFrameAnalyzer.dart';
import 'Frame.dart';
import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'Hit.dart';
import 'dart:math';
import 'OldFrameResult.dart';
import 'OldCalibrationResult.dart';

BaseFrameAnalyzer OldFrameAnalyzer() {
  const HIT_BITMAP_SIZE = 60;

  @override
  Hit checkHit(Frame frame, BaseFrameResult frameresult,
      BaseCalibrationResult calibration) {
    OldFrameResult frameResult;
    OldCalibrationResult calibration;
    var max = calibration.max;
  }
}
// should already be in rgb
