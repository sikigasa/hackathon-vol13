import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hackathon_vol13/utils/convertJpeg.dart';

final model = GenerativeModel(
  model: 'gemini-1.5-flash',
  apiKey: Platform.environment['GEMINI_API_KEY'] ?? '',
);

Future<DataPart> fileToPart(String mimeType, String path) async {
  return DataPart(mimeType, await File(path).readAsBytes());
}

final prompt =
    'この写真に移っている物がレシートだった場合、支払いをした合計金額をの数字のみを出力してください。2枚以上存在する場合、それぞれの合計金額を足した数字のみを出力して下さい。レシートでなく、金額が書かれていた場合金額の数値のみを出力して下さい。それ以外だった場合-1を出力してください。';
itoTextWithGemini(CameraImage cameraImage) async {
  // Convert CameraImage to DataPart
  final rgbImage = ImageUtils.convertCameraImage(cameraImage);
  final jpegBytes = convertRgbToJpeg(
      rgbImage.getBytes(), cameraImage.width, cameraImage.height);
  // final jpegBytes = await convertCameraImageToJpeg(cameraImage);
  final image = DataPart('image/jpeg', jpegBytes);

  // debug save jpeg
  // saveJpeg(jpegBytes);

  final response = await model.generateContent([
    Content.multi([TextPart(prompt), image])
  ]);
  return response.text;
}
