import 'package:flutter/material.dart';
import 'package:singify_project/model/song.dart';
import 'package:singify_project/screens/song_screen.dart';

class SearchSongScreen extends StatefulWidget {
  final String userEmail;
  const SearchSongScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<SearchSongScreen> createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  final String query = 'Nirvana';
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
                decoration: const InputDecoration(
                  hintText: 'Type a song name...',
                  prefixIcon: Icon(Icons.search),
                ),
                controller: controller,
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
                          return ListTile(
                            leading: const Text("Image"),
                            title: Text(list[index].title),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SongScreen(
                                          title: list[index].title,
                                        )),
                              );
                            },
                          );
                        },
                        itemCount: 10,
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
