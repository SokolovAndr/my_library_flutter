class Author {
  final int? id;
  final String name;
  final String surname;

  const Author({required this.name, required this.surname, this.id});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'surname': surname,
  };
}
