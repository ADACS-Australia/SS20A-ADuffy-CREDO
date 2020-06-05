import 'package:camera/camera.dart';
import 'OldDetectorFragment.dart';

class CameraHelper {
  CameraController _controller;
  bool _cameraInitialized = false;

  init() async {
    List<CameraDescription> cameras = await availableCameras();
    int black_threshhold = 40;

    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) async {
      int frame_number = 0;
      // start camera stream
      await _controller // needs CameraInfo checks for orientation etc.
          .startImageStream((CameraImage image) =>
              processImageFrame(image, frame_number, black_threshhold));
    });
    _cameraInitialized = true;
  }

  void dispose() {
    _controller.dispose();
    _cameraInitialized = false;
  }

  toggleCamera() {
    if (_cameraInitialized == false) {
      init();
    } else {
      dispose();
    }
  }
}
