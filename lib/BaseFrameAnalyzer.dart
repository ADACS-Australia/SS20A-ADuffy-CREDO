import 'Frame.dart';
import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';

abstract class BaseFrameAnalyzer {
  checkHit(Frame frame, BaseFrameResult frameresult,
      BaseCalibrationResult calibration);
}

/// TODO: function bitmap2png still necessary? Dart comes with a 'to png' function already
