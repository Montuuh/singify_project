import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("hrllo Up"),
        ),
      ],
    );
  }
}
