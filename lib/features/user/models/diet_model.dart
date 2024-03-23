import 'dart:convert';

class DietModel {
  int id;
  DateTime createdAt;
  String name;
  String? description;

  DietModel({
    required this.id,
    required this.createdAt,
    required this.name,
    this.description,
  });

  DietModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? description,
  }) {
    return DietModel(
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

  factory DietModel.fromMap(Map<String, dynamic> map) {
    return DietModel(
      id: map['id'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DietModel.fromJson(String source) =>
      DietModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DietModel(id: $id, createdAt: $createdAt, name: $name, description: $description)';
  }

  @override
  bool operator ==(covariant DietModel other) {
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
