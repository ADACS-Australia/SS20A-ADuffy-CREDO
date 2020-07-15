import 'Frame.dart';
import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'package:camera/camera.dart';

abstract class BaseFrameAnalyzer {
  checkHit(Frame frame, BaseFrameResult frameresult,
      BaseCalibrationResult calibration, CameraImage image);
}

/// TODO: function bitmap2png still necessary? Dart comes with a 'to png' function already
