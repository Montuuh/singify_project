import 'package:flutter/material.dart';

class SearchArtistScreen extends StatelessWidget {
  const SearchArtistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Artist'),
      ),
    );
  }
}
