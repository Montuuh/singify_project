import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:singify_project/model/user.dart';
import 'package:singify_project/widgets/auth_gate.dart';
import 'package:singify_project/screens/screen_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const AuthGate(
      app: SingifyApp(),
    ),
  );
}

class SingifyApp extends StatelessWidget {
  const SingifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData user = UserData.newUser(FirebaseAuth.instance.currentUser!);
    return MaterialApp(
      title: 'Singify',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        backgroundColor: Colors.black87,
        primaryColor: Colors.amber[800],
        dividerColor: Colors.amber[800]?.withAlpha(150),
        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
      home: ScreenManager(user: user),
    );
  }
}
