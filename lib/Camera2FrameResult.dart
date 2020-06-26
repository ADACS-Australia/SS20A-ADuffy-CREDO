import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'OldCalibrationResult.dart';
import 'package:camera/camera.dart';

/// The code in this file is a direct adaptation from kotlin-jini.c in the original project code

class Camera2FrameResult extends BaseFrameResult {
  var bytes;
  int width;
  int height;
  int scaledWidth;
  int scaledHeight;
  int pixelPrecision;
  // TODO make sure all these are initialized appropriately

  calculateFrame(CameraImage imageProcessing, var blackThreshold) {
    int sum = 0;
    int max = 0;
    int maxIndex = 0;

    int scaleFactorWidth = width ~/ scaledWidth;
    int scaleFactorHeight = height ~/ scaledHeight;
    int scale = scaleFactorWidth * scaleFactorHeight;
    int scaledFrameSize = scaledWidth * scaledHeight;

    //int * scaledFrame= (int *)(malloc((sizeof(int))*scaledFrameSize));
    var scaledFrame;

    /// should be a list of memory size as stuff gets written into it?
    var b = 111; //(*env)->GetByteArrayElements(env, bytes, JNI_FALSE);
    var address = b; // TODO needs a better deifinition of b!!

    for (int r = 0; r < height; ++r) {
      int indexRow = r * width * pixelPrecision;
      int scaledIndexRow = r ~/ scaleFactorHeight * scaledWidth;
      int c = 0;
      while (c < width * pixelPrecision) {
        int index = indexRow + c;
        int resultIndex = scaledIndexRow +
            c / pixelPrecision ~/ scaleFactorWidth; //double check this equation
        int byteValue = (b + index); // & 0xff;
        scaledFrame[resultIndex] = scaledFrame[resultIndex] + byteValue;
        c += pixelPrecision;
      }
    }

    for (int i = 0; i < scaledFrameSize; ++i) {
      int virtualPixelValue = scaledFrame[i] / scale;
      sum += virtualPixelValue;
      if (virtualPixelValue > max) {
        max = virtualPixelValue;
        maxIndex = i;
      }
    }
  }

  @override
  isCovered(BaseCalibrationResult calibrationResult) {
    // TODO: implement isCovered
    throw UnimplementedError();
  }
}
