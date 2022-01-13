import 'dart:convert';
import 'config.dart';
import 'package:http/http.dart' as http;

Future<List<Song>> searchSongs(String query) async {
  try {
    final uri = Uri.https("api.discogs.com", "/database/search", {
      "q": query,
      "token": token,
    });
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final list = json['results'] as List;
    return list.map((m) => Song.fromJson(m)).toList();
  } catch (e) {
    rethrow;
  }
}

class Song {
  String songName;
  //String artist;
  //DateTime releaseDate;

  Song.fromJson(Map<String, dynamic> json) : songName = json['title'];
}
