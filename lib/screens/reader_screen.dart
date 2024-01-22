import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/reader_model.dart';
import 'package:my_library_flutter/services/database_helper.dart';

class ReaderScreen extends StatelessWidget {
  final Reader? reader;
  const ReaderScreen({Key? key, this.reader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final surNameController = TextEditingController();

    if (reader != null) {
      nameController.text = reader!.name;
      surNameController.text = reader!.surname;
    }

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            reader == null ? 'Добавление читателя' : 'Редактирование читателя'),
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
                    labelText: 'Имя читателя',
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
                    labelText: 'Фамилия читателя',
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

                      final Reader model =
                      Reader(name: name, surname: surname, id: reader?.id);
                      if (reader == null) {
                        await DatabaseHelper.addReader(model);
                      } else {
                        await DatabaseHelper.updateReader(model);
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
                      reader == null ? 'Добавить' : 'Редактировать',
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
