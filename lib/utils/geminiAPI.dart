import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final model = GenerativeModel(
  model: 'gemini-1.5-flash',
  apiKey: "apiKey",
);

Future<DataPart> fileToPart(String mimeType, String path) async {
  return DataPart(mimeType, await File(path).readAsBytes());
}

final prompt = 'This image is receipt. Please convert it to text.';
itoTextWithGemini(CameraImage cameraImage) async {
  final image = await fileToPart(
      'image/jpeg', 'path/to/image.jpg'); // Convert CameraImage to DataPart

  final response = await model.generateContent([
    Content.multi([TextPart(prompt), image])
  ]);
  print(response.text);
}
