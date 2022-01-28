// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';
//import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:singify_project/model/user.dart';

import 'config.dart';
import 'package:http/http.dart' as http;

Future<List<Song>> searchSongs(String query) async {
  try {
    final uri = Uri.https(
        "api.discogs.com", "/database/search", {"q": query, "token": token});
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final list = json['results'] as List;
    int length = list.length;
    for (int i = length - 1; i > -1; i--) {
      if (list[i]['type'] == "artist" || list[i]['type'] == "label") {
        list.removeAt(i);
      }
    }
    return list.map((m) => Song.fromJson(m)).toList();
  } catch (e) {
    rethrow;
  }
}

Future<List<Song>> searchArtistSongs(String name) async {
  try {
    final uri = Uri.https(
        "api.discogs.com", "/database/search", {"q": name, "token": token});
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final list = json['results'] as List;
    int length = list.length;
    for (int i = length - 1; i > -1; i--) {
      if (list[i]['type'] == "artist" || list[i]['type'] == "label") {
        list.removeAt(i);
      }
    }
    return list.map((m) => Song.fromJson(m)).toList();
  } catch (e) {
    rethrow;
  }
}

Stream<List<Song>> retrieveSongs(UserData user) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('favourites')
      .snapshots()
      .map(_songRetrieverFromSnapshot);
}

List<Song> _songRetrieverFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Song.fromFirestore(doc);
  }).toList();
}

class Song {
  String title;
  String artist;
  String cover;
  String year;
  List<String>? format;
  List<String>? label;
  List<String>? genre;
  List<String>? style;
  String catalogNumber;
  String link;

  Song.fromFirestore(DocumentSnapshot doc)
      : title = doc.id,
        artist = doc['artname'],
        cover = doc['cover'],
        year = doc['year'],
        catalogNumber = doc['catno'],
        link = doc['link'],
        format = doc['format'].cast<String>(),
        label = doc['label'].cast<String>(),
        genre = doc['genre'].cast<String>(),
        style = doc['style'].cast<String>();

  Song.fromJson(Map<String, dynamic> json)
      : title = (json['title'] as String)
            .substring((json['title'] as String).indexOf('-') + 2),
        artist = (json['title'] as String)
            .substring(0, (json['title'] as String).indexOf('-') - 1),
        cover = json['cover_image'],
        year = json['year'].toString(),
        format = json['format'] != null
            ? json['format'].map<String>((s) => s as String).toList()
            : null,
        label = json['label'] != null
            ? json['label'].map<String>((s) => s as String).toList()
            : null,
        genre = json['genre'] != null
            ? json['genre'].map<String>((s) => s as String).toList()
            : null,
        style = json['style'] != null
            ? json['style'].map<String>((s) => s as String).toList()
            : null,
        catalogNumber = json['catno'].toString(),
        link = "www.discogs.com" + json['uri'];
}
