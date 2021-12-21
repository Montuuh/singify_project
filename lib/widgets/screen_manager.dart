import 'package:flutter/material.dart';
import 'package:singify_project/screens/home.dart';
import 'package:singify_project/screens/library.dart';
import 'package:singify_project/screens/search_artist.dart';
import 'package:singify_project/screens/search_song.dart';
import 'package:singify_project/widgets/bottom_bar.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({Key? key}) : super(key: key);

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int screen = 0;

  Widget _centralScreen() {
    if (screen == 1) {
      return const SearchArtistScreen();
    } else if (screen == 2) {
      return const SearchSongScreen();
    } else if (screen == 3) {
      return const LibraryScreen();
    }

    screen = 0;
    return const MainScreen();
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
