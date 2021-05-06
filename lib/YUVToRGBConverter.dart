import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';

class YUVToRGBConverter {
  //Future<Image> convertYUV420toImageColor(CameraImage image) async {
  // changed from a future object to make querying image easier TODO needs to be tested!
  convertYUV420toImageColor(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    var imgImage; // Create Image buffer

    /// converts yuv to rgb unless already in rgb
    /// this is very dependant on the actual image format which will vary between operating systems
    /// something that might work is checkfor the raw image format and look up in the documentation what conversion is needed
    /// for ios you can do a ASCCI conversion of raw code to see if RGB or ARGB or BGRA (translates directly)
    if (image.format.raw == 1111970369) {
      //BGRA
      try {
        // TODO double check that this reproduces the image correctly
        /// with the decodeImage function it should be possible to just pass it all bytes and
        /// it gets converted automatically (only works if no colour conversion is required ?!)
        imgImage = img.decodeImage(image.planes[0].bytes);
      } catch (e) {
        print(">>>>>>>>>>>> ERROR:" + e.toString());
      }
    } else {
      try {
        imgImage = img.Image(width, height);
        final int uvRowStride = image.planes[1].bytesPerRow;
        final int uvPixelStride = image.planes[1].bytesPerPixel;

        print("uvRowStride: " + uvRowStride.toString());
        print("uvPixelStride: " + uvPixelStride.toString());

        /// we want to use the image package here because it will allow cropping and encoding (copyCrop, encodePng)

        // Fill image buffer with plane[0] from YUV420_888
        for (int x = 0; x < width; x++) {
          for (int y = 0; y < height; y++) {
            // for every row fill the columns
            final int uvIndex =
                uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
            final int index = y * width + x;

            final yp = image.planes[0].bytes[index];
            final up = image.planes[1].bytes[uvIndex];
            final vp = image.planes[2].bytes[uvIndex];
            // Calculate pixel color
            int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
            int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
                .round()
                .clamp(0, 255);
            int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
            // color: 0x FF  FF  FF  FF
            //           A   B   G   R
            imgImage.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
          }
        }

        /// returns just the Image which can then be encoded / cropped outside of this function

      } catch (e) {
        print(">>>>>>>>>>>> ERROR:" + e.toString());
      }
    }
    return imgImage;
  }
}
