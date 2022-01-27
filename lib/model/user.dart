import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:singify_project/model/artist.dart';
import 'package:singify_project/model/song.dart';

void addUser(String userEmail) {
  final db = FirebaseFirestore.instance;
  db.doc('/users/$userEmail').set({});
  addCollection('/users/$userEmail/favourites');
  addCollection('/users/$userEmail/artists');
}

void deleteUser(String userEmail) {
  final db = FirebaseFirestore.instance;
  db.doc('/users/$userEmail').delete();
}

void addCollection(String collectionPath) {
  final db = FirebaseFirestore.instance;
  db.collection(collectionPath).add({});
}

void addValue(String collectionPath, String title, dynamic value) {
  final db = FirebaseFirestore.instance;
  db.collection(collectionPath).add({title: value});
}

void addFavourite(String userEmail, Song song) async {
  final db = FirebaseFirestore.instance;
  DocumentReference doc = db
      .collection('users')
      .doc(userEmail)
      .collection('favourites')
      .doc(song.title);

  doc.set({
    'cover': song.cover,
    'year': song.year,
    'link': song.link,
    'catno': song.catalogNumber,
    'style': song.style,
    'label': song.label,
    'genre': song.genre,
    'format': song.format,
    'artname': song.artist
  });
}

void removeFavourite(String userEmail, String title) async {
  final db = FirebaseFirestore.instance;
  db
      .collection('users')
      .doc(userEmail)
      .collection('favourites')
      .doc(title)
      .delete();
}

void removeFavouriteArtist(String userEmail, String title) async {
  final db = FirebaseFirestore.instance;
  db
      .collection('users')
      .doc(userEmail)
      .collection('artists')
      .doc(title)
      .delete();
}

void addFavouriteArtist(String userEmail, Artist artist) async {
  final db = FirebaseFirestore.instance;
  DocumentReference doc = db
      .collection('users')
      .doc(userEmail)
      .collection('artists')
      .doc(artist.name);

  doc.set({
    'cover': artist.cover,
    'link': artist.link,
  });
}

Future<bool> isArtistFavourite(String userEmail, String name) async {
  var doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('artists')
      .doc(name)
      .get();

  return doc.exists;
}

Future<bool> isSongFavourite(String userEmail, String name) async {
  var doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('favourites')
      .doc(name)
      .get();

  return doc.exists;
}

class UserData {
  String email;

  UserData.newUser(User user) : email = user.email.toString();
}
