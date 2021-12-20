import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:singify_project/screens/main_screen.dart';
import 'package:singify_project/screens/search_artist.dart';
import 'package:singify_project/widgets/bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int screen = 0;

  Widget _centralScreen() {
    
    if (screen == 1) return const SearchArtistScreen();

    screen = 0;
    return const MainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: '/home',
      routes: {
        '/home': (context) => const MainScreen(),
        '/artist': (context) => const SearchArtistScreen(),
      },
      title: 'Singify',
      home: Scaffold(
        body: _centralScreen(),
        bottomNavigationBar: BottomBarMenu(
          index: screen,
          onIndexChanged: (index) {
            setState(() => screen = index);
          },
        ),
      ),
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
