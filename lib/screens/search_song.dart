import 'package:flutter/material.dart';
import 'package:singify_project/widgets/search_bar.dart';

class SearchSongScreen extends StatefulWidget {
  final String userEmail;
  const SearchSongScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<SearchSongScreen> createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Artist'),
        automaticallyImplyLeading: false,
      ),
      body: const SearchBar(
        hintText: 'Type a song name...',
      ),
    );
  }
}
