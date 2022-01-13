import 'package:flutter/material.dart';
import 'package:singify_project/model/song.dart';

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
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && controller.text == '') {
                  return const Center(child: Text('Search song'));
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Text('${controller.text} data loaded!');
                  },
                  itemCount: 50,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
