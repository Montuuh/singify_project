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
    int length = list.length;
    for (int i = length - 1; i > -1; i--) {
      if (list[i]['type'] == "artist" || list[i]['type'] == "label") {
        list.removeAt(i);
      }
    }
    int i = 0;
    return list.map((m) => Song.fromJson(m)).toList();
  } catch (e) {
    rethrow;
  }
}

class Song {
  String title;
  Artist artist;
  String cover;
  String year;
  List<String>? format;
  List<String>? label;
  List<String>? genre;
  List<String>? style;
  String catalogNumber;
  String link;

  Song.fromJson(Map<String, dynamic> json)
      : title = (json['title'] as String)
            .substring((json['title'] as String).indexOf('-') + 2),
        artist = Artist.fromSong(
          (json['title'] as String)
              .substring(0, (json['title'] as String).indexOf('-') - 1),
        ),
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
        link = "www.discogs.com/" + json['uri'];
}
