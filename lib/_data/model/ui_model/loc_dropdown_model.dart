import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class LocDropdownModel {
  final String id;
  final String subdistrict;
  final String city;
  final String latitude;
  final String longitude;

  const LocDropdownModel({
    required this.id,
    required this.subdistrict,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  LocDropdownModel copyWith({
    String? id,
    String? subdistrict,
    String? city,
    String? latitude,
    String? longitude,
  }) {
    return LocDropdownModel(
      id: id ?? this.id,
      subdistrict: subdistrict ?? this.subdistrict,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subdistrict': subdistrict,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocDropdownModel.fromMap(Map<String, dynamic> map) {
    return LocDropdownModel(
      id: map['id'] as String,
      subdistrict: map['subdistrict'] as String,
      city: map['city'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocDropdownModel.fromJson(String source) =>
      LocDropdownModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocDropdownModel(id: $id, subdistrict: $subdistrict, city: $city, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant LocDropdownModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.subdistrict == subdistrict &&
        other.city == city &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subdistrict.hashCode ^
        city.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
