import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/author_model.dart';
import 'package:my_library_flutter/screens/author_screen.dart';
import 'package:my_library_flutter/services/database_helper.dart';
import 'package:my_library_flutter/widgets/author_for_choosing_widget.dart';
import 'package:my_library_flutter/widgets/author_widget.dart';

class AuthorsForChoosingScreen extends StatefulWidget {
  const AuthorsForChoosingScreen({super.key});

  @override
  State<AuthorsForChoosingScreen> createState() => _AuthorsForChoosingScreenState();
}

class _AuthorsForChoosingScreenState extends State<AuthorsForChoosingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Авторы'),
        centerTitle: true,
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
                  itemBuilder: (context, index) => AuthorForChoosingWidget(
                    author: snapshot.data![index],
                      onTap: () async{

                        setState(() {});
                      }
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
