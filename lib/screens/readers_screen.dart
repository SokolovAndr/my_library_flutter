import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/reader_model.dart';
import 'package:my_library_flutter/screens/reader_screen.dart';
import 'package:my_library_flutter/services/database_helper.dart';
import 'package:my_library_flutter/widgets/reader_widget.dart';

class ReadersScreen extends StatefulWidget {
  const ReadersScreen({super.key});

  @override
  State<ReadersScreen> createState() => _ReadersScreenState();
}

class _ReadersScreenState extends State<ReadersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Читатели'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push( context,
              MaterialPageRoute(builder: (context) => const ReaderScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body:
      FutureBuilder<List<Reader>?>(
        future: DatabaseHelper.getAllReaders(),
        builder: (context, AsyncSnapshot<List<Reader>?> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          else if (snapshot.hasData){
            if(snapshot.data != null) {
              return ListView.builder(
                  itemBuilder: (context, index) => ReaderWidget(
                    reader: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReaderScreen(
                            reader: snapshot.data![index],
                          )));
                      setState(() {});
                    },
                    onLongPress: ()async {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text('Вы уверены, что хотите удалить читателя?'),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.red)),
                              onPressed: () async {
                                await DatabaseHelper.deleteReader(
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
              child: Text ('Список читателей пуст'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
