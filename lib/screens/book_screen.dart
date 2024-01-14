import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/book_model.dart';
import 'package:my_library_flutter/services/database_helper.dart';

class BookScreen extends StatelessWidget {
  final Book? book;
  const BookScreen({
    Key? key,
    this.book
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageController = TextEditingController();

    if(book != null){
      titleController.text = book!.title;
      descriptionController.text = book!.description;
      imageController.text = book!.image;
    }

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text( book == null
            ? 'Добавление книги'
            : 'Редактирование книги'
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
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Название',
                    labelText: 'Название книги',
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
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Описание',
                  labelText: 'Описание книги',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              //maxLines: 5,
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: TextFormField(
                controller: imageController,
                decoration: const InputDecoration(
                    hintText: 'Изображение',
                    labelText: 'Изображение книги',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
                keyboardType: TextInputType.multiline,
                onChanged: (str) {},
                //maxLines: 5,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.value.text;
                      final description = descriptionController.value.text;
                      final image = imageController.value.text;

                      if (title.isEmpty || description.isEmpty || image.isEmpty) {
                        return;
                      }

                      final Book model = Book(title: title, description: description, image: image, id: book?.id);
                      if(book == null){
                        await DatabaseHelper.addBook(model);
                      }else{
                        await DatabaseHelper.updateBook(model);
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
                    child: Text( book == null
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