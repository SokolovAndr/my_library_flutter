import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/reader_model.dart';

class ReaderWidget extends StatelessWidget {
  final Reader reader;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const ReaderWidget(
      {Key? key,
        required this.reader,
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
                          reader.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          reader.surname,
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