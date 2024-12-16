import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

final model = GenerativeModel(
  model: 'gemini-1.5-flash',
  apiKey: "apiKey",
);

Future<DataPart> fileToPart(String mimeType, String path) async {
  return DataPart(mimeType, await File(path).readAsBytes());
}

final prompt = 'This image is receipt. Please convert it to text.';
itoTextWithGemini(InputImage image) async {
  final image = await fileToPart('image/jpeg', 'resources/jetpack.jpg');

  final response = await model.generateContent([
    Content.multi([TextPart(prompt), image])
  ]);
  print(response.text);
}
