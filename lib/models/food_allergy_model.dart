import 'dart:convert';

class FoodAllergyModel {
  int id;
  DateTime createdAt;
  String name;
  String? description;

  FoodAllergyModel({
    required this.id,
    required this.createdAt,
    required this.name,
    this.description,
  });

  FoodAllergyModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? description,
  }) {
    return FoodAllergyModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'description': description,
    };
  }

  factory FoodAllergyModel.fromMap(Map<String, dynamic> map) {
    return FoodAllergyModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodAllergyModel.fromJson(String source) =>
      FoodAllergyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FoodAllergyModel(id: $id, createdAt: $createdAt, name: $name, description: $description)';
  }

  @override
  bool operator ==(covariant FoodAllergyModel other) {
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
