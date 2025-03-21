// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:kualiva/common/feature/current_location/current_location_placemark_model.dart';

part 'current_location_model.g.dart';

@immutable
@HiveType(typeId: 2)
class CurrentLocationModel {
  @HiveField(0)
  final String locationAddress;

  /// The name of the city associated with the placemark.
  @HiveField(1)
  final String locality;

  /// Additional city-level information for the placemark.
  @HiveField(2)
  final String subLocality;

  @HiveField(3)
  final CurrentLocationPlacemarkModel placemark;

  @HiveField(4)
  final double latitude;

  @HiveField(5)
  final double longitude;

  const CurrentLocationModel({
    required this.locationAddress,
    required this.locality,
    required this.subLocality,
    required this.placemark,
    required this.latitude,
    required this.longitude,
  });

  CurrentLocationModel copyWith({
    String? locationAddress,
    String? locality,
    String? subLocality,
    CurrentLocationPlacemarkModel? placemark,
    double? latitude,
    double? longitude,
  }) {
    return CurrentLocationModel(
      locationAddress: locationAddress ?? this.locationAddress,
      locality: locality ?? this.locality,
      subLocality: subLocality ?? this.subLocality,
      placemark: placemark ?? this.placemark,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationAddress': locationAddress,
      'locality': locality,
      'subLocality': subLocality,
      'placemark': placemark.toMap(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory CurrentLocationModel.fromMap(Map<String, dynamic> map) {
    return CurrentLocationModel(
      locationAddress: map['locationAddress'] as String,
      locality: map['locality'] as String,
      subLocality: map['subLocality'] as String,
      placemark: CurrentLocationPlacemarkModel.fromMap(
          map['placemark'] as Map<String, dynamic>),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentLocationModel.fromJson(String source) =>
      CurrentLocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentLocationModel(locationAddress: $locationAddress, locality: $locality, subLocality: $subLocality, placemark: $placemark, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant CurrentLocationModel other) {
    if (identical(this, other)) return true;

    return other.locationAddress == locationAddress &&
        other.locality == locality &&
        other.subLocality == subLocality &&
        other.placemark == placemark &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return locationAddress.hashCode ^
        locality.hashCode ^
        subLocality.hashCode ^
        placemark.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
