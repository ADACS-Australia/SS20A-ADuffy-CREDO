import 'package:camera/camera.dart';
import 'OldDetectorFragment.dart';

/// CameraHelper initializes a stream of images from one available camera

typedef cameraCoveredChangeCallback = Function(bool bCovered);

class CameraHelper {
  CameraController? _controller;
  bool _cameraInitialized = false;
  int blackThreshold = 40;
  cameraCoveredChangeCallback? _cameraCoveredChangeCallback;

  init() async {
    List<CameraDescription> cameras = await availableCameras();

    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller?.initialize().then((_) async {
      ///waits for camera controller to be initialized before starting stream
      int frame_number = 0;
      // start camera stream
      await _controller?.startImageStream((CameraImage
              image) => // CameraImage might be the wrong type to use here ??
          processImageFrame(image, frame_number, blackThreshold, _cameraCoveredChangeCallback));

      /// stream of images is directly passed to processing/calibration (see OldDetectorFragment.dart)
    });
    _cameraInitialized = true;
  }

  /// disposes of stream
  void dispose() {
    _controller?.dispose();
    _cameraInitialized = false;
  }

  ///checks if camera is already running and if so turn the stream off
  toggleCamera() {
    if (_cameraInitialized == false) {
      init();
    } else {
      dispose();
    }
  }

  cameraCoveredChange(cameraCoveredChangeCallback cb) {
    _cameraCoveredChangeCallback = cb;
  }
}
