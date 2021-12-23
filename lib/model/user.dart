import 'package:cloud_firestore/cloud_firestore.dart';

void addUser(String userEmail) {
  final db = FirebaseFirestore.instance;
  db.doc('/users/$userEmail').set({});
  addCollection('/users/$userEmail/likes');
}

void deleteUser(String userEmail) {
  final db = FirebaseFirestore.instance;
  db.doc('/users/$userEmail').delete();
}

void addCollection(String collectionPath) {
  final db = FirebaseFirestore.instance;
  db.collection(collectionPath).add({});
}
