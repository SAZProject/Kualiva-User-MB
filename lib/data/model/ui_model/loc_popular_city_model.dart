import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class LocPopularCityModel {
  final String cityImagePath;
  final String cityName;
  final double latitude;
  final double longitude;

  const LocPopularCityModel({
    required this.cityImagePath,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });

  LocPopularCityModel copyWith({
    String? cityImagePath,
    String? cityName,
    double? latitude,
    double? longitude,
  }) {
    return LocPopularCityModel(
      cityImagePath: cityImagePath ?? this.cityImagePath,
      cityName: cityName ?? this.cityName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityImagePath': cityImagePath,
      'cityName': cityName,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocPopularCityModel.fromMap(Map<String, dynamic> map) {
    return LocPopularCityModel(
      cityImagePath: map['cityImagePath'] as String,
      cityName: map['cityName'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocPopularCityModel.fromJson(String source) =>
      LocPopularCityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocPopularCityModel(cityImagePath: $cityImagePath, cityName: $cityName, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant LocPopularCityModel other) {
    if (identical(this, other)) return true;

    return other.cityImagePath == cityImagePath &&
        other.cityName == cityName &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return cityImagePath.hashCode ^
        cityName.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
