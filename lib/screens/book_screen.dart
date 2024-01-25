import 'package:flutter/material.dart';
import 'package:my_library_flutter/models/book_model.dart';
import 'package:my_library_flutter/screens/authors_for_choosing_screen.dart';
import 'package:my_library_flutter/screens/authors_screen.dart';
import 'package:my_library_flutter/services/database_helper.dart';

class BookScreen extends StatefulWidget {
  final Book? book;
  const BookScreen({Key? key, this.book}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageController = TextEditingController();
    final authorController = TextEditingController();

    if (widget.book != null) {
      titleController.text = widget.book!.title;
      descriptionController.text = widget.book!.description;
      imageController.text = widget.book!.image;
      authorController.text = widget.book!.authorId.toString();
    }

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.book == null ? 'Добавление книги' : 'Редактирование книги'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: ListView(
          //padding: const EdgeInsets.all(8),
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
                textCapitalization:
                    TextCapitalization.sentences, //текст с заглавной буквы
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
              textCapitalization: TextCapitalization.sentences,
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
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: TextFormField(
                controller: authorController,
                decoration: const InputDecoration(
                    hintText: 'Автор',
                    labelText: 'Автор книги',
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
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(10), //<-- SEE HERE
                ),
                title: Text("Здесь будет имя автора"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: ()  async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AuthorsForChoosingScreen()
                      ));
                  setState(() {});
                },
              ),
            ),
/*            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(10), //<-- SEE HERE
                ),
                title: Text("Здесь будет выбор жанра"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),*/
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 30),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.value.text;
                      final description = descriptionController.value.text;
                      final image = imageController.value.text;
                      final author = authorController.value.text;

                      if (title.isEmpty ||
                          description.isEmpty ||
                          image.isEmpty||
                          author.isEmpty) {
                        return;
                      }

                      final Book model = Book(
                          title: title,
                          description: description,
                          image: image,
                          authorId: int.parse(author),
                          id: widget.book?.id);
                      if (widget.book == null) {
                        await DatabaseHelper.addBook(model);
                      } else {
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
                    child: Text(
                      widget.book == null ? 'Добавить' : 'Редактировать',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
