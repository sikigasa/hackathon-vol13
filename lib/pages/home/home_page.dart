// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:hackathon_vol13/pages/cameras/camera_page.dart';

// class TakePhotoScreen extends ConsumerWidget {
//   const TakePhotoScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cameraControllerAsync = ref.watch(cameraControllerInitProvider);
//     final recognizeTextNotifier = ref.watch(textRecognitionProvider.notifier);
//     final recognizeText = ref.watch(textRecognitionProvider);

//     return Scaffold(
//       body: cameraControllerAsync.when(
//         data: (data) {
//           return Center(
//             child: Column(
//               children: [
//                 // カメラ正常時
//                 if (data != null)
//                   Column(
//                     children: [
//                       CameraPreview(data),
//                       Gap(20.h),
//                       FilledButton(
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(
//                             AppColorSchemes.lightColorScheme.primary,
//                           ),
//                         ),
//                         onPressed: () async {
//                           try {
//                             await scanImage(
//                               data,
//                               context,
//                               recognizeTextNotifier,
//                             );
//                           } 
//                           <省略>
//                         },
//                         child: const Text('テキストを読み取る'),
//                       ),
//                       Gap(20.h),
//                       Text(
//                         recognizeText ?? 'ここにテキストが表示されます。',
//                         style: const TextStyle(color: Colors.black),
//                       ),
//                     ],
//                   ),
// 		  <省略>

//   Future<void> scanImage(
//     CameraController cameraController,
//     BuildContext context,
//     TextRecognition recognizeTextNotifier,
//   ) async {
//     // 写真を撮影する
//     final pictureFile = await cameraController.takePicture();
//     final file = File(pictureFile.path);
//     // 撮影した写真を読み込む
//     final inputImage = InputImage.fromFile(file);
//     // TextRecognizerの初期化（scriptで日本語の読み取りを指定しています※androidは日本語指定は失敗するのでデフォルトで使用すること）
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.japanese);
//     // 画像から文字を読み取る（OCR処理）
//     final recognizedText = await textRecognizer.processImage(inputImage);
//     recognizeTextNotifier.setRecognizedText(recognizedText.text);
//   }
// }