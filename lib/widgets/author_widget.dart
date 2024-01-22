import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/author_model.dart';

class AuthorWidget extends StatelessWidget {
  final Author author;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const AuthorWidget(
      {Key? key,
        required this.author,
        required this.onTap,
        required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                SizedBox(width: 25),
                Expanded (
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          author.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          author.surname,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}