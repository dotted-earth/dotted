// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Location {
  int id;
  double lat;
  double lon;
  int parentId;

  Location({
    required this.id,
    required this.lat,
    required this.lon,
    required this.parentId,
  });

  Location copyWith({
    int? id,
    double? lat,
    double? lon,
    int? parentId,
  }) {
    return Location(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lat': lat,
      'lon': lon,
      'parent_id': parentId,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] as int,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      parentId: map['parent_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Location(id: $id, lat: $lat, lon: $lon, parentId: $parentId)';
  }

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.lat == lat &&
        other.lon == lon &&
        other.parentId == parentId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ lat.hashCode ^ lon.hashCode ^ parentId.hashCode;
  }
}
