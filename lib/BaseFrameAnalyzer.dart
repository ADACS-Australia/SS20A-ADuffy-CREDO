import 'Frame.dart';
import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';

abstract class BaseFrameAnalyzer {
  checkHit(Frame frame, BaseFrameResult frameresult,
      BaseCalibrationResult calibration);
}
// TO DO: function bitmap2png function --> neccecary ? how are we sending things
