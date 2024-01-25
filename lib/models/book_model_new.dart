class NewBook {
  final int? id;
  final String title;
  final String description;
  final String image;
  final String author;

  const NewBook({required this.title, required this.description, required this.image, this.id, required this.author});

  factory NewBook.fromJson(Map<String, dynamic> json) => NewBook(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    image: json['image'],
    author: json['author'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image': image,
    'author': author
  };
}
