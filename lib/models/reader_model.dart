class Reader {
  final int? id;
  final String name;
  final String surname;

  const Reader({required this.name, required this.surname, this.id});

  factory Reader.fromJson(Map<String, dynamic> json) => Reader(
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
