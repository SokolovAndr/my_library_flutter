class Book {
  final int? id;
  final String title;
  final String description;
  final String image;
  final int? authorId;

  const Book({required this.title, required this.description, required this.image, this.id, this.authorId});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      authorId: json['authorId'],
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'authorId': authorId
      };

  //function is required to convert a Book object into a map object that can be stored in the database.
}
