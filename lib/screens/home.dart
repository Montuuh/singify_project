import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:singify_project/model/user.dart';

class HomeScreen extends StatelessWidget {
  final String userEmail;
  const HomeScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        foregroundColor: Colors.amber[800],
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .doc("/users/$userEmail")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.data() != null) {
                    return Text('"$userEmail" is now in our firestore cloud!');
                  } else {
                    addUser(userEmail);
                    return Text('"$userEmail" is not in firestore!');
                  }
                }),
            Row(
              children: [
                const Text('Log out:'),
                IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log out',
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
