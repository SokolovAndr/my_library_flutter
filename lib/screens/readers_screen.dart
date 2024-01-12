import 'package:flutter/material.dart';

class ReadersScreen extends StatelessWidget {
  const ReadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Читатели",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
