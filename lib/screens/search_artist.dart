//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:singify_project/model/artist.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/artist_screen.dart';

class SearchArtistScreen extends StatefulWidget {
  final UserData user;
  const SearchArtistScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SearchArtistScreen> createState() => _SearchArtistScreenState();
}

class _SearchArtistScreenState extends State<SearchArtistScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Artist'),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.amber[800],
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 40,
            color: Colors.white10,
            child: Center(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Type an artist name...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                onSubmitted: (String value) {
                  setState(() {
                    controller.text = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: searchArtists(controller.text),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Artist>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(child: Text('None'));
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                    return const Center(child: Text('Active'));
                  case ConnectionState.done:
                    if (snapshot.hasData && controller.text != '') {
                      List<Artist> list = snapshot.data!;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Artist artist = list[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.network(artist.cover),
                              title: Text(artist.name),
                              onTap: () async {
                                bool fav = await isArtistFavourite(
                                    widget.user.email, artist.name);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArtistScreen(
                                      artist: artist,
                                      user: widget.user,
                                      favourite: fav,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        itemCount: list.length,
                      );
                    }
                    break;
                }
                return const Center();
              },
            ),
          )
        ],
      ),
    );
  }
}
