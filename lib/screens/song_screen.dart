import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:singify_project/model/song.dart';
import 'package:singify_project/model/user.dart';

class SongScreen extends StatefulWidget {
  SongScreen({
    Key? key,
    required this.song,
    required this.user,
  }) : super(key: key);

  final Song song;
  final UserData user;
  final db = FirebaseFirestore.instance;

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Song Information"),
            IconButton(
              onPressed: () {
                setState(() {
                  favourite = !favourite;
                });
                favourite
                    ? addFavourite(
                        widget.user.email, widget.song.title, widget.song.cover)
                    : removeFavourite(widget.user.email, widget.song.title);
              },
              icon: favourite
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
            )
          ],
        ),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Image.network(widget.song.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Text(
                  widget.song.title,
                  style: const TextStyle(fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(
              thickness: 10,
              height: 50,
              indent: 20,
              endIndent: 20,
            ),
            TextInfo(header: "Artist", text: widget.song.artist.name),
            TextInfo(header: "Year", text: widget.song.year),
            TextInfo(header: "Catalog Num", text: widget.song.catalogNumber),
          ],
        ),
      ),
    );
  }
}

class TextInfo extends StatelessWidget {
  const TextInfo({
    Key? key,
    required this.header,
    required this.text,
  }) : super(key: key);

  final String header;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 35),
      child: Row(
        children: [
          Text(
            header + ": ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.amber[700],
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
