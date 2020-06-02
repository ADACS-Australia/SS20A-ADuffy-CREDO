import 'package:sensors/sensors.dart';

AccelerometerEvent accelerometer;
init() {
  accelerometerEvents.listen((AccelerometerEvent event) {
    accelerometer = event;
  });
  print(accelerometerEvents.single);
}
