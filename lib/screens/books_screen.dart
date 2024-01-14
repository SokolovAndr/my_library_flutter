import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/database_helper.dart';
import '../widgets/book_widget.dart';
import 'book_screen.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Книги'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BookScreen()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body:
        FutureBuilder<List<Book>?>(
          future: DatabaseHelper.getAllBooks(),
          builder: (context, AsyncSnapshot<List<Book>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => BookWidget(
                    book: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookScreen(
                                book: snapshot.data![index],
                              )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Вы уверены, что хотите удалить книгу?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteBook(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Да'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Нет'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
            }
            else {
              return const Center(
                child: Text('Список книг пуст'),
              );
            }
            return const SizedBox.shrink();
          },
        )
    );
  }
}