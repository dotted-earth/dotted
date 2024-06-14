import 'dart:convert';

import 'package:dotted/models/address_model.dart';
import 'package:dotted/models/location_model.dart';

class PointOfInterestModel {
  int? id;
  String name;
  String description;
  int locationId;
  int addressId;
  LocationModel? location;
  AddressModel? address;

  PointOfInterestModel({
    this.id,
    required this.name,
    required this.description,
    required this.locationId,
    required this.addressId,
    this.location,
    this.address,
  });

  PointOfInterestModel copyWith({
    int? id,
    String? name,
    String? description,
    int? locationId,
    int? addressId,
    LocationModel? location,
    AddressModel? address,
  }) {
    return PointOfInterestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      locationId: locationId ?? this.locationId,
      addressId: addressId ?? this.addressId,
      location: location ?? this.location,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'location_id': locationId,
      'address_id': addressId,
      'location': location?.toMap(),
      'address': address?.toMap(),
    };
  }

  factory PointOfInterestModel.fromMap(Map<String, dynamic> map) {
    return PointOfInterestModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      description: map['description'] as String,
      locationId: map['location_id'] as int,
      addressId: map['address_id'] as int,
      location: map['location'] != null
          ? LocationModel.fromMap(map['location'] as Map<String, dynamic>)
          : null,
      address: map['address'] != null
          ? AddressModel.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PointOfInterestModel.fromJson(String source) =>
      PointOfInterestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PointOfInterestModel(id: $id, name: $name, description: $description, locationId: $locationId, addressId: $addressId, location: $location, address: $address)';
  }

  @override
  bool operator ==(covariant PointOfInterestModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.locationId == locationId &&
        other.addressId == addressId &&
        other.location == location &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        locationId.hashCode ^
        addressId.hashCode ^
        location.hashCode ^
        address.hashCode;
  }
}
