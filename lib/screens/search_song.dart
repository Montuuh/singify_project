import 'package:flutter/material.dart';
import 'package:singify_project/model/song.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/song_screen.dart';

class SearchSongScreen extends StatefulWidget {
  final UserData user;
  const SearchSongScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SearchSongScreen> createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
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
        title: const Text('Search Song'),
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
                  hintText: 'Type a song name...',
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
              future: searchSongs(controller.text),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(child: Text('None'));
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                    return const Center(child: Text('Active'));
                  case ConnectionState.done:
                    if (snapshot.hasData && controller.text != '') {
                      List<Song> list = snapshot.data!;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Song song = list[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.network(song.cover),
                              title: Text(song.title),
                              subtitle: Text(song.artist.name),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SongScreen(
                                      song: song,
                                      user: widget.user,
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
