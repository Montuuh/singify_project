import 'package:flutter/material.dart';

class SearchSongScreen extends StatelessWidget {
  final String userEmail;
  const SearchSongScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Song'),
      ),
    );
  }
}
