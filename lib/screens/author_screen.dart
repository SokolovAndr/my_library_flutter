import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/author_model.dart';
import 'package:my_library_flutter/services/database_helper.dart';

class AuthorScreen extends StatelessWidget {
  final Author? author;
  const AuthorScreen({Key? key, this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final surNameController = TextEditingController();

    if (author != null) {
      nameController.text = author!.name;
      surNameController.text = author!.surname;
    }

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            author == null ? 'Добавление автора' : 'Редактирование автора'),
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
                textCapitalization:
                    TextCapitalization.sentences, //текст с заглавной буквы
                //maxLines: 3,
                decoration: const InputDecoration(
                    hintText: 'Имя',
                    labelText: 'Имя писателя',
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
              padding: const EdgeInsets.only(bottom: 30.0),
              child: TextFormField(
                controller: surNameController,
                textCapitalization:
                    TextCapitalization.sentences, //текст с заглавной буквы
                //maxLines: 3,
                decoration: const InputDecoration(
                    hintText: 'Фамилия',
                    labelText: 'Фамилия писателя',
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
                      final surname = surNameController.value.text;

                      if (name.isEmpty || surname.isEmpty) {
                        return;
                      }

                      final Author model =
                          Author(name: name, surname: surname, id: author?.id);
                      if (author == null) {
                        await DatabaseHelper.addAuthor(model);
                      } else {
                        await DatabaseHelper.updateAuthor(model);
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
                    child: Text(
                      author == null ? 'Добавить' : 'Редактировать',
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
