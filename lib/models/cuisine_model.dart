import 'dart:convert';

class CuisineModel {
  int id;
  DateTime createdAt;
  String name;
  String? description;

  CuisineModel({
    required this.id,
    required this.createdAt,
    required this.name,
    this.description,
  });

  CuisineModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? description,
  }) {
    return CuisineModel(
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

  factory CuisineModel.fromMap(Map<String, dynamic> map) {
    return CuisineModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CuisineModel.fromJson(String source) =>
      CuisineModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CuisineModel(id: $id, createdAt: $createdAt, name: $name, description: $description)';
  }

  @override
  bool operator ==(covariant CuisineModel other) {
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
