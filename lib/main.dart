import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_vol13/pages/home/nav_button_icons.dart';
import 'database/wallet.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  // final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  // final firstCamera = cameras.first;
  final database = AppDatabase();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp(
    database: database,
  ));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LightWalletBook',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: ButtonNavWithIcons(database: database),
    );
  }
}
