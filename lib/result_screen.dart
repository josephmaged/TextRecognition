import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const snackBar = SnackBar(content: Text("Copied"));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        actions: [
          IconButton(
            onPressed: () {
              FlutterClipboard.copy(text).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(snackBar),
              );
            },
            icon: const Icon(
              Icons.copy,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Text(text),
      ),
    );
  }
}
