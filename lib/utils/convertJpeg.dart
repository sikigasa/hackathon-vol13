import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:camera/camera.dart';

Future<Uint8List> convertCameraImageToJpeg(CameraImage cameraImage) async {
  // CameraImageの平面データを取得
  final yPlane = cameraImage.planes[0];
  final uPlane = cameraImage.planes[1];
  final vPlane = cameraImage.planes[2];

  // YUV -> RGB 変換
  final imgImage = img.Image.fromBytes(
    width: cameraImage.width,
    height: cameraImage.height,
    bytes: _convertYUV420toRGB(
      yPlane.bytes,
      uPlane.bytes,
      vPlane.bytes,
      cameraImage.width,
      cameraImage.height,
    ).buffer,
    format: img.Format.uint8,
    order: img.ChannelOrder.bgra,
  );

  // JPEGエンコード
  final jpegBytes = img.JpegEncoder().encode(imgImage);
  return Uint8List.fromList(jpegBytes);
}

// YUV420をRGBに変換する関数
Uint8List _convertYUV420toRGB(Uint8List yPlane, Uint8List uPlane,
    Uint8List vPlane, int width, int height) {
  final int frameSize = width * height;
  final Uint8List rgb = Uint8List(frameSize * 3);

  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      int y = yPlane[j * width + i] & 0xFF;
      int u = uPlane[(j ~/ 2) * (width ~/ 2) + (i ~/ 2)] & 0xFF;
      int v = vPlane[(j ~/ 2) * (width ~/ 2) + (i ~/ 2)] & 0xFF;

      // YUV -> RGBの公式変換
      int r = (y + 1.402 * (v - 128)).round();
      int g = (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).round();
      int b = (y + 1.772 * (u - 128)).round();

      // RGBを制限
      r = r.clamp(0, 255);
      g = g.clamp(0, 255);
      b = b.clamp(0, 255);

      int pixelIndex = (j * width + i) * 3;
      rgb[pixelIndex] = r;
      rgb[pixelIndex + 1] = g;
      rgb[pixelIndex + 2] = b;
    }
  }

  return rgb;
}

Uint8List yuv420ToRgb(CameraImage cameraImage) {
  final int width = cameraImage.width;
  final int height = cameraImage.height;

  final Uint8List yPlane = cameraImage.planes[0].bytes;
  final Uint8List uPlane = cameraImage.planes[1].bytes;
  final Uint8List vPlane = cameraImage.planes[2].bytes;

  final int uvRowStride = cameraImage.planes[1].bytesPerRow;
  final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

  final Uint8List rgbBytes = Uint8List(width * height * 3); // RGBは3バイト/ピクセル

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final int yIndex = y * width + x;
      final int uvIndex = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;

      final int yValue = yPlane[yIndex] & 0xFF;
      final int uValue = uPlane[uvIndex] & 0xFF;
      final int vValue = vPlane[uvIndex] & 0xFF;

      final int r = (yValue + 1.402 * (vValue - 128)).round().clamp(0, 255);
      final int g =
          (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
              .round()
              .clamp(0, 255);
      final int b = (yValue + 1.772 * (uValue - 128)).round().clamp(0, 255);

      final int rgbIndex = yIndex * 3;
      rgbBytes[rgbIndex] = r;
      rgbBytes[rgbIndex + 1] = g;
      rgbBytes[rgbIndex + 2] = b;
    }
  }

  return rgbBytes;
}

Uint8List convertRgbToJpeg(Uint8List rgbData, int width, int height) {
  // RGBデータをImageオブジェクトに変換
  final image =
      img.Image.fromBytes(width: width, height: height, bytes: rgbData.buffer);

  // ImageをJPEGにエンコード
  final jpegBytes = img.encodeJpg(image);

  // Uint8Listとして返す
  return Uint8List.fromList(jpegBytes);
}
