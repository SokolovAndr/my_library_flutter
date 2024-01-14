class Action {
  final int? id;
  final int readerId;
  final int modelId;
  final bool type;

  const Action({required this.readerId, required this.modelId, required this.type, this.id});

  factory Action.fromJson(Map<String, dynamic> json) => Action(
      id: json['id'],
      readerId: json['readerId'],
      modelId: json['modelId'],
      type: json['type']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'readerId': readerId,
    'modelId': modelId,
    'type': type
  };
}
