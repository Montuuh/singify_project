import 'package:flutter/material.dart';
import 'package:singify_project/model/user.dart';

class LibraryScreen extends StatelessWidget {
  final UserData user;
  const LibraryScreen({Key? key, required this.user}) : super(key: key);

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
