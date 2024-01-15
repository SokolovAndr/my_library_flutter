import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/genre_model.dart';
import 'package:my_library_flutter/screens/genre_screen.dart';
import 'package:my_library_flutter/services/database_helper.dart';
import 'package:my_library_flutter/widgets/genre_widget.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Жанры'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push( context,
          MaterialPageRoute(builder: (context) => const GenreScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body:
      FutureBuilder<List<Genre>?>(
        future: DatabaseHelper.getAllGenres(),
        builder: (context, AsyncSnapshot<List<Genre>?> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          else if (snapshot.hasData){
            if(snapshot.data != null) {
              return ListView.builder(
                  itemBuilder: (context, index) => GenreWidget(
                    genre: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GenreScreen(
                          genre: snapshot.data![index],
                        )));
                      setState(() {});
                    },
                    onLongPress: ()async {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text('Вы уверены, что хотите удалить жанр?'),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.red)),
                              onPressed: () async {
                                await DatabaseHelper.deleteGenre(
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
              child: Text ('Список жанров пуст'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
