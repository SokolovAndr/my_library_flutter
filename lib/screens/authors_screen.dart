import 'package:flutter/material.dart';

class AuthorsScreen extends StatelessWidget {
  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Писатели",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
