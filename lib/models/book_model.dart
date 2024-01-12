class Book {
  final int? id;
  final String title;
  final String description;

  const Book({required this.title, required this.description, this.id});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
      id: json['id'],
      title: json['title'],
      description: json['description']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
