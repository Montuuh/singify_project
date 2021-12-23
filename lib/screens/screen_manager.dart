import 'package:flutter/material.dart';
import 'package:singify_project/screens/home.dart';
import 'package:singify_project/screens/library.dart';
import 'package:singify_project/screens/search_artist.dart';
import 'package:singify_project/screens/search_song.dart';
import 'package:singify_project/widgets/bottom_bar.dart';

class ScreenManager extends StatefulWidget {
  final String userEmail;
  const ScreenManager({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int screen = 0;

  Widget _centralScreen() {
    if (screen == 1) {
      return SearchArtistScreen(userEmail: widget.userEmail.toString());
    } else if (screen == 2) {
      return SearchSongScreen(userEmail: widget.userEmail.toString());
    } else if (screen == 3) {
      return LibraryScreen(userEmail: widget.userEmail.toString());
    }

    screen = 0;
    return HomeScreen(userEmail: widget.userEmail.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _centralScreen(),
      bottomNavigationBar: BottomBarMenu(
        index: screen,
        onIndexChanged: (index) {
          setState(() => screen = index);
        },
      ),
    );
  }
}
