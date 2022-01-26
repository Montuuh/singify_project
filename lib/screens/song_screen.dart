import 'package:flutter/material.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Song Information"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Text(
              title,
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }
}
