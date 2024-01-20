import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_vol13/pages/home/nav_button_icons.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackathon Vol.13',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: ButtonNavWithIcons(camera: camera),
    );
  }
}
