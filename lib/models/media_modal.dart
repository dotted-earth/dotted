import 'dart:convert';

import 'package:dotted/models/media_type_enum.dart';

class MediaModel {
  int? id;
  DateTime? createdAt;
  String url;
  MediaTypeEnum mediaType;

  MediaModel({
    this.id,
    this.createdAt,
    required this.url,
    required this.mediaType,
  });

  MediaModel copyWith({
    int? id,
    DateTime? createdAt,
    String? url,
    MediaTypeEnum? mediaType,
  }) {
    return MediaModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
      mediaType: mediaType ?? this.mediaType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'url': url,
      'media_type': mediaType.name,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      url: map['url'] as String,
      mediaType: MediaTypeEnum.values
          .firstWhere((element) => element.name == map['media_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MediaModel(id: $id, createdAt: $createdAt, url: $url, mediaType: $mediaType)';

  @override
  bool operator ==(covariant MediaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.url == url &&
        other.mediaType == mediaType;
  }

  @override
  int get hashCode =>
      id.hashCode ^ createdAt.hashCode ^ url.hashCode ^ mediaType.hashCode;
}
