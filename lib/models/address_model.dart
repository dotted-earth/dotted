// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dotted/models/location_model.dart';

class AddressModel {
  int id;
  String street1;
  String? street2;
  String city;
  String? state;
  String country;
  String? postalCode;
  String? addressString;
  LocationModel? location;

  AddressModel({
    required this.id,
    required this.street1,
    this.street2,
    required this.city,
    this.state,
    required this.country,
    this.postalCode,
    this.addressString,
    this.location,
  });

  AddressModel copyWith({
    int? id,
    String? street1,
    String? street2,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? addressString,
    LocationModel? location,
  }) {
    return AddressModel(
      id: id ?? this.id,
      street1: street1 ?? this.street1,
      street2: street2 ?? this.street2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      addressString: addressString ?? this.addressString,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'street1': street1,
      'street2': street2,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'address_string': addressString,
      'location': location?.toMap(),
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int,
      street1: map['street1'],
      street2: map['street2'],
      city: map['city'] as String,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] as String,
      postalCode:
          map['postal_code'] != null ? map['postal_code'] as String : null,
      addressString: map['address_string'] != null
          ? map['address_string'] as String
          : null,
      location: map['location'] != null
          ? LocationModel.fromMap(map['location'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(id: $id, street1: $street1, street2: $street2, city: $city, state: $state, country: $country, postalCode: $postalCode, addressString: $addressString, location: $location)';
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.street1 == street1 &&
        other.street2 == street2 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.postalCode == postalCode &&
        other.addressString == addressString &&
        other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        street1.hashCode ^
        street2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        postalCode.hashCode ^
        addressString.hashCode ^
        location.hashCode;
  }
}
