import 'package:flutter/material.dart';
import 'package:singify_project/model/artist.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/artist_screen.dart';

class FavArtistScreen extends StatelessWidget {
  const FavArtistScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Artists'),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: StreamBuilder(
        stream: retrieveArtists(user),
        builder: (context, AsyncSnapshot<List<Artist>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(backgroundColor: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Artist> list = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                Artist artist = list[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(artist.cover),
                    title: Text(artist.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtistScreen(
                            artist: artist,
                            user: user,
                            favourite: true,
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
        },
      ),
    );
  }
}
