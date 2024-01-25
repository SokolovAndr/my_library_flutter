import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/book_model.dart';

class BookWidget extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const BookWidget(
      {Key? key,
        required this.book,
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
                /*Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(book.image),
                    ),
                  )
                ),*/
                SizedBox(
                  width: 100,
                  height: 150,
                  child: Image.network(
                    book.image,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Center(
                        child:
                        /*Text(
                        'Мы не смогли загрузить изображение :(',
                        style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                      ),*/
                        Image.asset("assets/images/error_icon.png", width: 50,height: 50,),
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          book.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Text(
                        book.description,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        //maxLines: 3,
                      ),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Text(
                        book.authorId.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        //maxLines: 3,
                      )
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