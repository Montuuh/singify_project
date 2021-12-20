import 'package:flutter/material.dart';

class BottomBarMenu extends StatefulWidget {
  final int index;
  final void Function(int) onIndexChanged;
  const BottomBarMenu({
    Key? key,
    required this.index,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  State<BottomBarMenu> createState() => _BottomBarMenuState();
}

class _BottomBarMenuState extends State<BottomBarMenu> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home), 
          label: 'Home',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_search),
          label: 'Artists',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Songs',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Library',
          backgroundColor: Colors.black87,
        ),
      ],
      currentIndex: widget.index,
      selectedItemColor: Colors.amber[800],
      onTap: widget.onIndexChanged,
    );
  }
}
