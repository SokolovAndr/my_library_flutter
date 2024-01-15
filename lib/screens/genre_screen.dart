import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/genre_model.dart';
import 'package:my_library_flutter/services/database_helper.dart';

class GenreScreen extends StatelessWidget {
  final Genre? genre;
  const GenreScreen({
    Key? key,
    this.genre
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    if(genre != null){
      nameController.text = genre!.name;
    }

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text( genre == null
            ? 'Добавление жанра'
            : 'Редактирование Жанра'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Center(
                child: Text(
                  'Внесите данные',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.sentences,  //текст с заглавной буквы
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Название',
                    labelText: 'Название жанра',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final name = nameController.value.text;

                      if (name.isEmpty ) {
                        return;
                      }

                      final Genre model = Genre(name:name, id: genre?.id);
                      if(genre == null){
                        await DatabaseHelper.addGenre(model);
                      }else{
                        await DatabaseHelper.updateGenre(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text( genre == null
                        ? 'Добавить' : 'Редактировать',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}