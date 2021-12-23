import 'package:flutter/material.dart';
import 'package:singify_project/widgets/search_bar.dart';

class SearchArtistScreen extends StatefulWidget {
  final String userEmail;
  const SearchArtistScreen({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<SearchArtistScreen> createState() => _SearchArtistScreenState();
}

class _SearchArtistScreenState extends State<SearchArtistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Artist'),
        automaticallyImplyLeading: false,
      ),
      body: const SearchBar(
        hintText: 'Type an artist name...',
      ),
    );
  }
}
