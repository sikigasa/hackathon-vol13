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
