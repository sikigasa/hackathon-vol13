import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

InputImage convert({
  required CameraDescription camera,
  required CameraImage cameraImage,
}) {
  final WriteBuffer allBytes = WriteBuffer();
  for (Plane plane in cameraImage.planes) {
    allBytes.putUint8List(plane.bytes);
  }
  final bytes = allBytes.done().buffer.asUint8List();

  final Size imageSize =
      Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

  final fixBytes = Nv21Converter(cameraImage).getNv21Uint8List();

  final InputImageRotation imageRotation =
      InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
          InputImageRotation.rotation0deg;

  final InputImageFormat inputImageFormat =
      InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
          InputImageFormat.nv21;

  // final planeData = cameraImage.planes.map(
  //   (Plane plane) {
  //     return InputImageMetadata(
  //       bytesPerRow: plane.bytesPerRow,
  //       height: plane.height,
  //       width: plane.width,
  //     );
  //   },
  // ).toList();

  final inputImageData = InputImageMetadata(
    size: imageSize,
    rotation: imageRotation,
    format: inputImageFormat,
    bytesPerRow: cameraImage.planes[0].bytesPerRow,
    // planeData: planeData,
  );

  final inputImage =
      InputImage.fromBytes(bytes: fixBytes, metadata: inputImageData);

  return inputImage;
}

extension Nv21Converter on CameraImage {
  Uint8List getNv21Uint8List() {
    var width = this.width;
    var height = this.height;

    var yPlane = planes[0];
    var uPlane = planes[1];
    var vPlane = planes[2];

    var yBuffer = yPlane.bytes;
    var uBuffer = uPlane.bytes;
    var vBuffer = vPlane.bytes;

    var numPixels = (width * height * 1.5).toInt();
    var nv21 = List<int>.filled(numPixels, 0);

    // Full size Y channel and quarter size U+V channels.
    int idY = 0;
    int idUV = width * height;
    var uvWidth = width ~/ 2;
    var uvHeight = height ~/ 2;
    // Copy Y & UV channel.
    // NV21 format is expected to have YYYYVU packaging.
    // The U/V planes are guaranteed to have the same row stride and pixel stride.
    // getRowStride analogue??
    var uvRowStride = uPlane.bytesPerRow;
    // getPixelStride analogue
    var uvPixelStride = uPlane.bytesPerPixel ?? 0;
    var yRowStride = yPlane.bytesPerRow;
    var yPixelStride = yPlane.bytesPerPixel ?? 0;

    for (int y = 0; y < height; ++y) {
      var uvOffset = y * uvRowStride;
      var yOffset = y * yRowStride;

      for (int x = 0; x < width; ++x) {
        nv21[idY++] = yBuffer[yOffset + x * yPixelStride];

        if (y < uvHeight && x < uvWidth) {
          var bufferIndex = uvOffset + (x * uvPixelStride);
          //V channel
          nv21[idUV++] = vBuffer[bufferIndex];
          //V channel
          nv21[idUV++] = uBuffer[bufferIndex];
        }
      }
    }
    return Uint8List.fromList(nv21);
  }
}
