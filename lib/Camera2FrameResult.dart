import 'dart:typed_data';

import 'BaseFrameResult.dart';
import 'BaseCalibrationResult.dart';
import 'OldCalibrationResult.dart';
import 'package:camera/camera.dart';

/// The code in this file is a direct adaptation from kotlin-jini.c in the original project code

class Camera2FrameResult extends BaseFrameResult {
  var bytes;
  //int width;
  //int height;
  int scaledWidth;
  int scaledHeight;
  int pixelPrecision;
  // TODO make sure all these are initialized appropriately

  var avg;
  int sum;
  int max;
  int maxIndex;

  calculateFrame(CameraImage imageProcessing, var blackThreshold) {
    sum = 0;
    max = 0;
    maxIndex = 0;

    /// these all need to be changed
    scaledWidth = 0;
    scaledHeight = 0;
    pixelPrecision = 0;

    int scaleFactorWidth = imageProcessing.width ~/ scaledWidth;
    int scaleFactorHeight = imageProcessing.height ~/ scaledHeight;
    int scale = scaleFactorWidth * scaleFactorHeight;
    int scaledFrameSize = scaledWidth * scaledHeight;

    var scaledFrame = Uint8List(4 * scaledFrameSize);

    // unit8list - and we only care about the Y plane which is plane 0
    var b = imageProcessing.planes[0].bytes;
    // var address = b; // TODO is adress needed at all ??

    for (int r = 0; r < imageProcessing.height; ++r) {
      int indexRow = r * imageProcessing.width * pixelPrecision;
      int scaledIndexRow = r ~/ scaleFactorHeight * scaledWidth;
      int c = 0;
      while (c < imageProcessing.width * pixelPrecision) {
        int index = indexRow + c;
        int resultIndex = scaledIndexRow +
            c / pixelPrecision ~/ scaleFactorWidth; //double check this equation
        int byteValue = (b[r] + index);

        /// does not do what i think it should do
        scaledFrame[resultIndex] = scaledFrame[resultIndex] + byteValue;
        c += pixelPrecision;
      }
    }

    for (int i = 0; i < scaledFrameSize; ++i) {
      int virtualPixelValue = scaledFrame[i] ~/ scale;
      sum += virtualPixelValue;
      if (virtualPixelValue > max) {
        max = virtualPixelValue;
        maxIndex = i;
      }
    }

    avg = sum / scaledFrameSize;

    var results = [avg, max, maxIndex];
    return results;
  }

  @override
  isCovered(BaseCalibrationResult calibrationResult) {
    // TODO: implement isCovered
    throw UnimplementedError();
  }
}
