// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'current_location_placemark_model.g.dart';

@immutable
@HiveType(typeId: 7)
class CurrentLocationPlacemarkModel {
  /// The name associated with the placemark.
  @HiveField(0)
  final String? name;

  /// The street associated with the placemark.
  @HiveField(1)
  final String? street;

  /// The abbreviated country name, according to the two letter (alpha-2) [ISO standard](https://www.iso.org/iso-3166-country-codes.html).
  @HiveField(2)
  final String? isoCountryCode;

  /// The name of the country associated with the placemark.
  @HiveField(3)
  final String? country;

  /// The postal code associated with the placemark.
  @HiveField(4)
  final String? postalCode;

  /// The name of the state or province associated with the placemark.
  @HiveField(5)
  final String? administrativeArea;

  /// Additional administrative area information for the placemark.
  @HiveField(6)
  final String? subAdministrativeArea;

  /// The name of the city associated with the placemark.
  @HiveField(7)
  final String? locality;

  /// Additional city-level information for the placemark.
  @HiveField(8)
  final String? subLocality;

  /// The street address associated with the placemark.
  @HiveField(9)
  final String? thoroughfare;

  /// Additional street address information for the placemark.
  @HiveField(10)
  final String? subThoroughfare;

  const CurrentLocationPlacemarkModel({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  CurrentLocationPlacemarkModel copyWith({
    String? name,
    String? street,
    String? isoCountryCode,
    String? country,
    String? postalCode,
    String? administrativeArea,
    String? subAdministrativeArea,
    String? locality,
    String? subLocality,
    String? thoroughfare,
    String? subThoroughfare,
  }) {
    return CurrentLocationPlacemarkModel(
      name: name ?? this.name,
      street: street ?? this.street,
      isoCountryCode: isoCountryCode ?? this.isoCountryCode,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      administrativeArea: administrativeArea ?? this.administrativeArea,
      subAdministrativeArea:
          subAdministrativeArea ?? this.subAdministrativeArea,
      locality: locality ?? this.locality,
      subLocality: subLocality ?? this.subLocality,
      thoroughfare: thoroughfare ?? this.thoroughfare,
      subThoroughfare: subThoroughfare ?? this.subThoroughfare,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'street': street,
      'isoCountryCode': isoCountryCode,
      'country': country,
      'postalCode': postalCode,
      'administrativeArea': administrativeArea,
      'subAdministrativeArea': subAdministrativeArea,
      'locality': locality,
      'subLocality': subLocality,
      'thoroughfare': thoroughfare,
      'subThoroughfare': subThoroughfare,
    };
  }

  factory CurrentLocationPlacemarkModel.fromMap(Map<String, dynamic> map) {
    return CurrentLocationPlacemarkModel(
      name: map['name'] != null ? map['name'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      isoCountryCode: map['isoCountryCode'] != null
          ? map['isoCountryCode'] as String
          : null,
      country: map['country'] != null ? map['country'] as String : null,
      postalCode:
          map['postalCode'] != null ? map['postalCode'] as String : null,
      administrativeArea: map['administrativeArea'] != null
          ? map['administrativeArea'] as String
          : null,
      subAdministrativeArea: map['subAdministrativeArea'] != null
          ? map['subAdministrativeArea'] as String
          : null,
      locality: map['locality'] != null ? map['locality'] as String : null,
      subLocality:
          map['subLocality'] != null ? map['subLocality'] as String : null,
      thoroughfare:
          map['thoroughfare'] != null ? map['thoroughfare'] as String : null,
      subThoroughfare: map['subThoroughfare'] != null
          ? map['subThoroughfare'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentLocationPlacemarkModel.fromJson(String source) =>
      CurrentLocationPlacemarkModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentLocationPlacemarkModel(name: $name, street: $street, isoCountryCode: $isoCountryCode, country: $country, postalCode: $postalCode, administrativeArea: $administrativeArea, subAdministrativeArea: $subAdministrativeArea, locality: $locality, subLocality: $subLocality, thoroughfare: $thoroughfare, subThoroughfare: $subThoroughfare)';
  }

  @override
  bool operator ==(covariant CurrentLocationPlacemarkModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.street == street &&
        other.isoCountryCode == isoCountryCode &&
        other.country == country &&
        other.postalCode == postalCode &&
        other.administrativeArea == administrativeArea &&
        other.subAdministrativeArea == subAdministrativeArea &&
        other.locality == locality &&
        other.subLocality == subLocality &&
        other.thoroughfare == thoroughfare &&
        other.subThoroughfare == subThoroughfare;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        street.hashCode ^
        isoCountryCode.hashCode ^
        country.hashCode ^
        postalCode.hashCode ^
        administrativeArea.hashCode ^
        subAdministrativeArea.hashCode ^
        locality.hashCode ^
        subLocality.hashCode ^
        thoroughfare.hashCode ^
        subThoroughfare.hashCode;
  }
}
