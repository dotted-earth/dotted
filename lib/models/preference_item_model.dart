// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PreferenceItemModel {
  final int id;
  final String name;

  PreferenceItemModel({
    required this.id,
    required this.name,
  });

  PreferenceItemModel copyWith({
    int? id,
    String? name,
  }) {
    return PreferenceItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory PreferenceItemModel.fromMap(Map<String, dynamic> map) {
    return PreferenceItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PreferenceItemModel.fromJson(String source) =>
      PreferenceItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PreferenceItemModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant PreferenceItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
