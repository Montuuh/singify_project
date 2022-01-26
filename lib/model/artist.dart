import 'dart:convert';
//import 'dart:ffi';
import 'config.dart';
import 'package:http/http.dart' as http;

Future<List<Artist>> searchArtists(String query) async {
  try {
    final uri = Uri.https(
        "api.discogs.com", "/database/search", {"q": query, "token": token});
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final list = json['results'] as List;
    for (int i = 0; i < list.length; i++) {
      if (list[i]['type'] != "artist") list.removeAt(i);
    }
    return list.map((m) => Artist.fromJson(m)).toList();
  } catch (e) {
    rethrow;
  }
}

class Artist {
  String name;

  Artist.fromJson(Map<String, dynamic> json) : name = json['title'];

  Artist.fromSong(String artistName) : name = artistName;
}
