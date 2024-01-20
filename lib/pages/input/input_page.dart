import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hackathon_vol13/pages/cameras/camera_page.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  // late CameraController _controller;
  // late Future<void> _initializeControllerFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   // To display the current output from the Camera,
  //   // create a CameraController.
  //   _controller = CameraController(
  //     // Get a specific camera from the list of available cameras.
  //     widget.camera,
  //     // Define the resolution to use.
  //     ResolutionPreset.medium,
  //   );

  //   // Next, initialize the controller. This returns a Future.
  //   _initializeControllerFuture = _controller.initialize();
  // }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraPage(
                  // camera: widget.camera,
                  ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.camera_alt_outlined),
      ),
      body: InputForm(),
      // SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     children: <Widget>[
      //       // TextField(),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text("Input yor price"),
      //       ),
      //       TextFormField(
      //         decoration: const InputDecoration(
      //           hintText: 'Enter your price',
      //         ),
      //         validator: (String? value) {
      //           if (value == null || value.isEmpty) {
      //             return 'Please enter some text';
      //           }
      //           return null;
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final items = ["item1", "item2", "item3"];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: "item1",
            decoration: const InputDecoration(
              hintText: 'Enter price',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some price';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
