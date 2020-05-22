import 'BaseCalibrationResult.dart';

class OldCalibrationResult extends BaseCalibrationResult {
  int blackThreshhold;
  int avg;
  int max;
  var DEFAULT_BLACK_THRESHOLD = 40;

  @override
  save() {
    // TODO: implement save
    throw UnimplementedError();
  }
}
