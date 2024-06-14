// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationModel {
  int id;
  double lat;
  double lon;
  int? parentId;

  LocationModel({
    required this.id,
    required this.lat,
    required this.lon,
    this.parentId,
  });

  LocationModel copyWith({
    int? id,
    double? lat,
    double? lon,
    int? parentId,
  }) {
    return LocationModel(
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

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as int,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      parentId: map['parent_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(id: $id, lat: $lat, lon: $lon, parentId: $parentId)';
  }

  @override
  bool operator ==(covariant LocationModel other) {
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
