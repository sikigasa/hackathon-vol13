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

final prompt = 'この写真は何ですか?';
itoTextWithGemini(CameraImage cameraImage) async {
  // Convert CameraImage to DataPart
  final jpegBytes = convertRgbToJpeg(
      yuv420ToRgb(cameraImage), cameraImage.width, cameraImage.height);
  final image = DataPart('image/jpeg', jpegBytes);

  final response = await model.generateContent([
    Content.multi([TextPart(prompt), image])
  ]);
  return response.text;
}
