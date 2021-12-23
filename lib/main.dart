import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
    final user = FirebaseAuth.instance.currentUser!;
    return MaterialApp(
      title: 'Singify',
      home: ScreenManager(userEmail: user.email.toString()),
    );
  }
}
