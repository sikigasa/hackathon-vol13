import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:camera/camera.dart';

import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

// CameraImageをJPEGに変換する
Future<Uint8List> convertCameraImageToJpeg(CameraImage cameraImage) async {
  final int width = cameraImage.width;
  final int height = cameraImage.height;

  // YUV420からRGB形式に変換
  final img.Image rgbImage = _convertYUV420ToImage(cameraImage);

  // RGB画像をJPEG形式にエンコード
  final Uint8List jpegBytes = Uint8List.fromList(img.encodeJpg(rgbImage));

  return jpegBytes;
}

// YUV420形式をRGB画像に変換
img.Image _convertYUV420ToImage(CameraImage cameraImage) {
  final int width = cameraImage.width;
  final int height = cameraImage.height;

  final Uint8List yPlane = cameraImage.planes[0].bytes;
  final Uint8List uPlane = cameraImage.planes[1].bytes;
  final Uint8List vPlane = cameraImage.planes[2].bytes;

  final int uvRowStride = cameraImage.planes[1].bytesPerRow;
  final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

  // RGB画像データを生成
  final img.Image image = img.Image(width: width, height: height);

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

      // ピクセルを設定
      image.setPixel(x, y, img.ColorInt32.rgb(r, g, b));
    }
  }

  return image;
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
