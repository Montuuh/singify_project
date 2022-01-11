import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  final String userEmail;
  const LibraryScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
