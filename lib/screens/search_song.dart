import 'package:flutter/material.dart';

class SearchSongScreen extends StatelessWidget {
  const SearchSongScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Song'),
      ),
    );
  }
}
