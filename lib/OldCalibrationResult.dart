import 'BaseCalibrationResult.dart';

class OldCalibrationResult extends BaseCalibrationResult {
  int blackThreshold;
  int avg;
  int max;
  static const int DEFAULT_BLACK_THRESHOLD = 40;

  @override
  save() {
    // TODO: implement save
    throw UnimplementedError();
  }
}
