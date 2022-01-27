import 'dart:convert';
//import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:singify_project/model/user.dart';
import 'config.dart';
import 'package:http/http.dart' as http;

Future<List<Artist>> searchArtists(String query) async {
  try {
    final uri = Uri.https(
        "api.discogs.com", "/database/search", {"q": query, "token": token});
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final list = json['results'] as List;
    int length = list.length;
    for (int i = length - 1; i > -1; i--) {
      if (list[i]['type'] != "artist") {
        list.removeAt(i);
      }
    }
    return list.map((m) => Artist.fromJson(m)).toList();
  } catch (e) {
    rethrow;
  }
}

Stream<List<Artist>> retrieveArtists(UserData user) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('artists')
      .snapshots()
      .map(_songRetrieverFromSnapshot);
}

List<Artist> _songRetrieverFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Artist.fromFirestore(doc);
  }).toList();
}

Future<Artist> retrieveArtistFromName(String name) async {
  List<Artist> artists = await searchArtists(name);
  return artists.first;
}

class Artist {
  String name;
  String cover;
  String link;

  Artist.fromJson(Map<String, dynamic> json)
      : name = json['title'],
        cover = json['cover_image'],
        link = "www.discogs.com" + json['uri'];

  Artist.fromFirestore(DocumentSnapshot doc)
      : name = doc.id,
        cover = doc['cover'],
        link = doc['link'];
}
