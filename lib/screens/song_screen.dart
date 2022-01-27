import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:singify_project/model/song.dart';
import 'package:singify_project/model/user.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

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
            TextButton(
              onPressed: () {
                _launchURL(widget.song.link);
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
            TagTable(list: widget.song.format, header: "Formats"),
            TagTable(list: widget.song.genre, header: "Genres", topMargin: 12),
            TagTable(list: widget.song.style, header: "Style", topMargin: 12),
            TagTable(
                list: widget.song.label,
                header: "Label/s",
                topMargin: 12,
                tagLimit: 8),
            const Divider(
              thickness: 10,
              height: 50,
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

class TagTable extends StatelessWidget {
  const TagTable({
    Key? key,
    required this.list,
    required this.header,
    this.topMargin = 0,
    this.tagLimit = 100000,
  }) : super(key: key);

  final List<String>? list;
  final String header;
  final double topMargin;
  final int tagLimit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topMargin),
        HighText(text: header, padding: 10, deltaFontSize: 3),
        Center(
          heightFactor: 0.95,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 15,
              children: [
                for (int i = 0;
                    list != null && i < list!.length && i < tagLimit;
                    i++)
                  Tag(
                    bgColor: Colors.amber[700],
                    name: list![i],
                    textColor: Colors.white,
                  ),
                if (tagLimit != 10000 && tagLimit < list!.length)
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: const Text("More...",
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({
    Key? key,
    required this.name,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  final String name;
  final Color? bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: bgColor,
      ),
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: textColor,
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
          HighText(text: header, padding: 0),
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

class HighText extends StatelessWidget {
  const HighText({
    Key? key,
    required this.text,
    required this.padding,
    this.deltaFontSize,
    this.colon = true,
  }) : super(key: key);

  final String text;
  final double padding;
  final double? deltaFontSize;
  final bool colon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Text(
        text + (colon ? ": " : " "),
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
