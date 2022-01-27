import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:singify_project/model/artist.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/song_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistScreen extends StatefulWidget {
  ArtistScreen({
    Key? key,
    required this.artist,
    required this.user,
    required this.favourite,
  }) : super(key: key);

  final Artist artist;
  final UserData user;
  final db = FirebaseFirestore.instance;
  bool favourite;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Artist Information"),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.favourite = !widget.favourite;
                });
                widget.favourite
                    ? addFavouriteArtist(widget.user.email, widget.artist)
                    : removeFavouriteArtist(
                        widget.user.email, widget.artist.name);
              },
              icon: widget.favourite
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
              child: Image.network(widget.artist.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Text(
                  widget.artist.name,
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
            TextButton(
              onPressed: () {
                _launchURL(widget.artist.link);
              },
              child: const Center(
                child: HighText(
                    padding: 0,
                    text: "Web Link",
                    deltaFontSize: -3,
                    colon: false),
              ),
            ),
            const Divider(
              thickness: 10,
              height: 46,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
