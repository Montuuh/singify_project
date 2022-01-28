import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:singify_project/model/artist.dart';
import 'package:singify_project/model/song.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/screens/library.dart';

class HomeScreen extends StatelessWidget {
  final UserData user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Home"),
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
        foregroundColor: Colors.amber[800],
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: user.profileImage != null
                  ? Image.network(user.profileImage!)
                  : const Center(child: Icon(Icons.account_circle, size: 144)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: HighText(
                  text: user.email,
                  padding: 0,
                  colon: false,
                ),
              ),
            ),
            const Divider(
              thickness: 10,
              height: 40,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 32,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HighText(
                          text: "Last Favourite\nSong",
                          padding: 0,
                          colon: false,
                          centered: true,
                          deltaFontSize: -4,
                        ),
                        StreamBuilder(
                          stream: retrieveSongs(user),
                          builder:
                              (context, AsyncSnapshot<List<Song>> snapshot) {
                            if (snapshot.hasData) {
                              List<Song> songs = snapshot.data!;
                              Widget ret;
                              songs.isNotEmpty
                                  ? ret = Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.network(
                                        songs.last.cover,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : ret = Center(
                                      heightFactor: 5,
                                      child: Column(
                                        children: const [
                                          Text("No songs"),
                                        ],
                                      ));
                              return ret;
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 32,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HighText(
                          text: "Last Favourite\nArtists",
                          padding: 0,
                          colon: false,
                          centered: true,
                          deltaFontSize: -4,
                        ),
                        StreamBuilder(
                          stream: retrieveArtists(user),
                          builder:
                              (context, AsyncSnapshot<List<Artist>> snapshot) {
                            if (snapshot.hasData) {
                              List<Artist> songs = snapshot.data!;
                              Widget ret;
                              songs.isNotEmpty
                                  ? ret = Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.network(
                                        songs.last.cover,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : ret = Center(
                                      heightFactor: 5,
                                      child: Column(
                                        children: const [
                                          Text("No songs"),
                                        ],
                                      ));
                              return ret;
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
