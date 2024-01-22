import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/author_model.dart';
import 'package:my_library_flutter/screens/author_screen.dart';
import 'package:my_library_flutter/services/database_helper.dart';
import 'package:my_library_flutter/widgets/author_widget.dart';

class AuthorsScreen extends StatefulWidget {
  const AuthorsScreen({super.key});

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Авторы'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push( context,
              MaterialPageRoute(builder: (context) => const AuthorScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body:
      FutureBuilder<List<Author>?>(
        future: DatabaseHelper.getAllAuthors(),
        builder: (context, AsyncSnapshot<List<Author>?> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          else if (snapshot.hasData){
            if(snapshot.data != null) {
              return ListView.builder(
                  itemBuilder: (context, index) => AuthorWidget(
                    author: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AuthorScreen(
                            author: snapshot.data![index],
                          )));
                      setState(() {});
                    },
                    onLongPress: ()async {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text('Вы уверены, что хотите удалить автора?'),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.red)),
                              onPressed: () async {
                                await DatabaseHelper.deleteAuthor(
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
                      }
                      );
                    },
                  ),
                  itemCount: snapshot.data!.length
              );
            }
          }
          else {
            return const Center(
              child: Text ('Список писателей пуст'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
