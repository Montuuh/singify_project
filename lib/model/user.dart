import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addUser(String userEmail) {
  final db = FirebaseFirestore.instance;
  db.doc('/users/$userEmail').set({});
  addCollection('/users/$userEmail/favourites');
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

void addFavourite(String userEmail, String title, String cover) async {
  final db = FirebaseFirestore.instance;
  db
      .collection('users')
      .doc(userEmail)
      .collection('favourites')
      .doc(title)
      .set({'title': title, 'cover': cover});
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

class UserData {
  String email;

  UserData.newUser(User user) : email = user.email.toString();
}
