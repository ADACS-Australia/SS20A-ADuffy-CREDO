import 'package:battery/battery.dart';

import 'AllSensorsHelper.dart';

typedef cameraCoveredChangeCallback = Function(bool bCovered);
typedef chargeStateChangeCallback = Function(String state);

class Globals {
  /// We create an instance of all sensors helper here that can be used globally
  var detectorHelper = AllSensorsHelper();

  bool isCameraCovered = false;
  cameraCoveredChangeCallback? onCameraCoveredChange;

  /// Create a battery sensory to detect battery percentage and charge state
  var battery = Battery();
  var chargeState = "Unknown";
  chargeStateChangeCallback? onChargeStateChange;

  Globals() {
    battery.onBatteryStateChanged.listen((BatteryState state) {
      chargeState = "Unknown";
      if (state == BatteryState.full) {
        chargeState = "YES";
      } else if (state == BatteryState.charging) {
        chargeState = "YES";
      } else if (state == BatteryState.discharging) {
        chargeState = "NO";
      }

      if (onChargeStateChange != null) {
        onChargeStateChange!(chargeState);
      }
    });
  }
}
