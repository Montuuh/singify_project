import 'package:flutter/material.dart';
import 'package:singify_project/model/song.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/song_screen.dart';

class FavSongScreen extends StatelessWidget {
  const FavSongScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Songs'),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: StreamBuilder(
        stream: retrieveSongs(user),
        builder: (context, AsyncSnapshot<List<Song>> snapshot) {
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
            List<Song> list = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                Song song = list[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(song.cover),
                    title: Text(song.title),
                    subtitle: Text(song.artist),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongScreen(
                            song: song,
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
