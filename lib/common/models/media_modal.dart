import 'dart:convert';

class MedialModel {
  int? id;
  DateTime? createdAt;
  String url;
  MedialModel({
    this.id,
    this.createdAt,
    required this.url,
  });

  MedialModel copyWith({
    int? id,
    DateTime? createdAt,
    String? url,
  }) {
    return MedialModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'url': url,
    };
  }

  factory MedialModel.fromMap(Map<String, dynamic> map) {
    return MedialModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedialModel.fromJson(String source) =>
      MedialModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MedialModel(id: $id, createdAt: $createdAt, url: $url)';

  @override
  bool operator ==(covariant MedialModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.createdAt == createdAt && other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ url.hashCode;
}
