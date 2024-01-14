class Book {
  final int? id;
  final String title;
  final String description;
  final String image;

  const Book({required this.title, required this.description, required this.image, this.id});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image']
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image
      };
}
