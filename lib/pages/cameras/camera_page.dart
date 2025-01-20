// import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hackathon_vol13/utils/geminiAPI.dart';
import 'package:hackathon_vol13/utils/camera2.dart';

List<CameraDescription> cameras = [];

class CameraPage extends StatefulWidget {
  // final CameraDescription camera;
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraState();
}

class _CameraState extends State<CameraPage> {
  late CameraController _controller;
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.japanese);
  bool isReady = false;
  bool skipScanning = false;
  bool isScanned = false;
  RecognizedText? _recognizedText;
  String? _geminiResponse;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    _setup();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  _processImage(CameraImage availableImage) async {
    if (!mounted || skipScanning) return;
    setState(() {
      skipScanning = true;
    });

    // final inputImage = convert(
    //   camera: cameras[0],
    //   cameraImage: availableImage,
    // );

    // final inputImage = cameraImageToInputImage(
    //     availableImage, cameras[0], _controller.value.deviceOrientation);

    _geminiResponse = await itoTextWithGemini(availableImage);
    print("gemini: $_geminiResponse");

    // use MLkit
    // _recognizedText = await _textRecognizer.processImage(inputImage!);
    // print(_recognizedText!.text);

    if (!mounted) return;
    setState(() {
      skipScanning = false;
    });
    // mlkit
    // if (_recognizedText != null && _recognizedText!.text.isNotEmpty) {
    //   _controller.stopImageStream();
    //   setState(() {
    //     isScanned = true;
    //   });
    // }
    // gemini
    if (_geminiResponse != null && _geminiResponse!.isNotEmpty) {
      _controller.stopImageStream();
      setState(() {
        isScanned = true;
      });
    }
  }

  Future<void> _setup() async {
    cameras = await availableCameras();

    _controller = CameraController(cameras[0], ResolutionPreset.max);

    await _controller.initialize().catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });

    if (!mounted) {
      return;
    }

    setState(() {
      isReady = true;
    });

    _controller.startImageStream(_processImage);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = !isReady || !_controller.value.isInitialized;
    return Scaffold(
      appBar: AppBar(
        title: const Text('テキスト読み取り画面'),
      ),
      body: Column(
          children: isLoading
              ? [const Center(child: CircularProgressIndicator())]
              : [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 16 / 12,
                        child: Stack(
                          children: [
                            ClipRect(
                              child: Transform.scale(
                                scale: _controller.value.aspectRatio * 12 / 9,
                                child: Center(
                                  child: CameraPreview(_controller),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  isScanned
                      ? Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  child: const Text('再度読み取る'),
                                  onPressed: () {
                                    setState(() {
                                      isScanned = false;
                                      _geminiResponse = null;
                                    });
                                    _controller.startImageStream(_processImage);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('登録する'),
                                  onPressed: () {
                                    Navigator.pop(context, _geminiResponse!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : const Text('読み込み中'),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                          // _recognizedText != null ? _recognizedText!.text : ''),
                          _geminiResponse != null ? _geminiResponse! : ''),
                    ),
                  )
                ]),
    );
  }
}
