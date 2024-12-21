import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final model = GenerativeModel(
  model: 'gemini-1.5-flash',
  apiKey: Platform.environment['GEMINI_API_KEY'] ?? '',
);

Future<DataPart> fileToPart(String mimeType, String path) async {
  return DataPart(mimeType, await File(path).readAsBytes());
}

final prompt = 'This image is receipt. Please give the total amount.';
itoTextWithGemini(CameraImage cameraImage) async {
  // Convert CameraImage to DataPart
  final image = DataPart('image/jpeg', cameraImage.planes[0].bytes);

  final response = await model.generateContent([
    Content.multi([TextPart(prompt), image])
  ]);
  return response.text;
}
