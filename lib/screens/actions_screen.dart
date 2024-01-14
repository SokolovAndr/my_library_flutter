import 'package:flutter/material.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Операции",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
