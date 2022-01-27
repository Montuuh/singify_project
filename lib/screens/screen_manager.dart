import 'package:flutter/material.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/home.dart';
import 'package:singify_project/screens/library.dart';
import 'package:singify_project/screens/search_artist.dart';
import 'package:singify_project/screens/search_song.dart';
import 'package:singify_project/widgets/bottom_bar.dart';

class ScreenManager extends StatefulWidget {
  final UserData user;
  const ScreenManager({Key? key, required this.user}) : super(key: key);

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int screen = 0;

  Widget _centralScreen() {
    if (screen == 1) {
      return SearchArtistScreen(user: widget.user);
    } else if (screen == 2) {
      return SearchSongScreen(user: widget.user);
    } else if (screen == 3) {
      return LibraryScreen(user: widget.user);
    }

    screen = 0;
    return HomeScreen(userEmail: widget.user.email);
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
