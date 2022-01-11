import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  final String hintText;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;
  String? _textTyped;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: false,
          centerTitle: false,
          flexibleSpace: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 40,
              color: Colors.white10,
              child: Center(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: const Icon(Icons.search),
                  //suffixIcon: Icon(Icons.camera_alt),
                ),
                //controller: _controller,
                onSubmitted: (String value) {
                  _textTyped = value;
                },
              )),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(
              height: 400,
              child: Center(
                child: Text(
                  'Here is where the list will be displayed',
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
