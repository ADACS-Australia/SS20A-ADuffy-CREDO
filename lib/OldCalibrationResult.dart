import 'BaseCalibrationResult.dart';

class OldCalibrationResult extends BaseCalibrationResult {
  int blackThreshold = 0;
  int avg = 0;
  int max = 0;
  static const int DEFAULT_BLACK_THRESHOLD = 40;

  @override
  save() {
    // TODO: implement save
    throw UnimplementedError();
  }
}
