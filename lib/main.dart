import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:singify_project/widgets/screen_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SingifyApp());
}

class SingifyApp extends StatelessWidget {
  const SingifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Singify',
      home: ScreenManager(),
    );
  }
}

class FirebaseConexion extends StatelessWidget {
  const FirebaseConexion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      body: StreamBuilder(
        stream: db.doc("/users/dmontufo@gmail.com").snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final doc = snapshot.data!.data();
          if (doc != null) {
            return Center(child: Text(doc['password']));
          } else {
            return const Center(child: Text("doc is null!"));
          }
        },
      ),
    );
  }
}
