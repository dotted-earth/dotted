import 'dart:convert';

class RecreationModel {
  int id;
  DateTime createdAt;
  String name;
  String? description;

  RecreationModel({
    required this.id,
    required this.createdAt,
    required this.name,
    this.description,
  });

  RecreationModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? description,
  }) {
    return RecreationModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.millisecondsSinceEpoch,
      'name': name,
      'description': description,
    };
  }

  factory RecreationModel.fromMap(Map<String, dynamic> map) {
    return RecreationModel(
      id: map['id'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecreationModel.fromJson(String source) =>
      RecreationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecreationModel(id: $id, createdAt: $createdAt, name: $name, description: $description)';
  }

  @override
  bool operator ==(covariant RecreationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        description.hashCode;
  }
}
