//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:singify_project/model/artist.dart';

class SearchArtistScreen extends StatefulWidget {
  final String userEmail;
  const SearchArtistScreen({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<SearchArtistScreen> createState() => _SearchArtistScreenState();
}

class _SearchArtistScreenState extends State<SearchArtistScreen> {
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
        title: const Text('Search Artist'),
        automaticallyImplyLeading: false,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
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
                  hintText: 'Type an artist name...',
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
                          return ListTile(
                            leading: const Text("Image"),
                            title: Text(list[index].name),
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
