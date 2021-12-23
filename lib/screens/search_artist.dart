import 'package:flutter/material.dart';

class SearchArtistScreen extends StatelessWidget {
  final String userEmail;
  const SearchArtistScreen({Key? key, required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Artist'),
      ),
    );
  }
}
