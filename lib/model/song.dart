import 'dart:convert';
//import 'dart:ffi';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'package:singify_project/model/artist.dart';

Future<List<Song>> searchSongs(String query) async {
  try {
    final uri = Uri.https(
        "api.discogs.com", "/database/search", {"q": query, "token": token});
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final list = json['results'] as List;
    for (int i = 0; i < list.length; i++) {
      if (list[i]['type'] == "artist") list.removeAt(i);
    }
    return list.map((m) => Song.fromJson(m)).toList();
  } catch (e) {
    rethrow;
  }
}

class Song {
  String title;
  Artist artist;

  Song.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        artist = Artist.fromSong(json['title']);
  //releaseDate = DateTime.parse(json['release_date']),
}
