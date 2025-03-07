import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hackathon_vol13/utils/convertJpeg.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future<DataPart> fileToPart(String mimeType, String path) async {
  return DataPart(mimeType, await File(path).readAsBytes());
}

final prompt =
    'この写真に移っている物がレシートだった場合、支払いをした合計金額をの数字のみを出力してください。2枚以上存在する場合、それぞれの合計金額を足した数字のみを出力して下さい。レシートでなく、写真の中に金額が書かれていた場合、金額の数値のみを出力して下さい。それ以外だった場合-1を出力してください。';

itoTextWithGemini(CameraImage cameraImage) async {
  // Convert CameraImage to DataPart
  final rgbImage = ImageUtils.convertCameraImage(cameraImage);
  final jpegBytes = convertRgbToJpeg(
      rgbImage.getBytes(), cameraImage.width, cameraImage.height);
  // final jpegBytes = await convertCameraImageToJpeg(cameraImage);
  final image = DataPart('image/jpeg', jpegBytes);
  var apiKey = prefs?.getString('GEMINI_API_KEY') ?? '';

  // debug save jpeg
  // saveJpeg(jpegBytes);

  prefs = await SharedPreferences.getInstance();
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );
  try {
    final response = await model.generateContent([
      Content.multi([TextPart(prompt), image])
    ]);
    return response.text;
  } catch (e) {
    return 'エラーが発生しました';
  }
}
