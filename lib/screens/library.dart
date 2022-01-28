import 'package:flutter/material.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/fav_artist_screen.dart';
import 'package:singify_project/screens/fav_song_screen.dart';

class LibraryScreen extends StatelessWidget {
  final UserData user;
  const LibraryScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  iconSize: 150,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavSongScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                  icon: Image.network(
                    'https://img.myloview.com/stickers/playlist-metro-tile-icon-400-216669979.jpg',
                  ),
                ),
                const HighText(
                    text: "Favourite Songs", padding: 0, colon: false),
              ],
            ),
            Column(
              children: [
                IconButton(
                  iconSize: 150,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavArtistScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                  icon: Image.network(
                    'https://www.citypng.com/public/uploads/preview/address-contact-book-black-icon-11640520529mhwu7ngb7h.png',
                  ),
                ),
                const HighText(
                    text: "Favourite Artists", padding: 0, colon: false),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HighText extends StatelessWidget {
  const HighText({
    Key? key,
    required this.text,
    required this.padding,
    this.deltaFontSize,
    this.colon = true,
    this.centered = false,
  }) : super(key: key);

  final String text;
  final double padding;
  final double? deltaFontSize;
  final bool colon;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Text(
        text + (colon ? ": " : " "),
        textAlign: centered ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontSize: 20 + (deltaFontSize ?? 0),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Colors.amber[700],
        ),
      ),
    );
  }
}
