import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:textrecognition/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image;
  final picker = ImagePicker();
  final _textRecognizer = TextRecognizer();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Recognition"),
        actions: [
          ElevatedButton(
            onPressed: scanText,
            child: const Text('Scan'),
          ),
        ],
      ),
      body: image == null
          ? const Center(
              child: Image(
                height: 100,
                width: 100,
                image: AssetImage("assets/imageIcon.png"),
              ),
            )
          : Image.file(
              File(
                image!.path,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future scanText() async {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final file = File(image!.path);
      final inputImage = InputImage.fromFile(file);
      final recognizerText = await _textRecognizer.processImage(inputImage);
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            text: recognizerText.text,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "An error occurred when scanning the text",
          ),
        ),
      );
    }
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile;
      } else {
        print("No image selected");
      }
    });
  }
}
