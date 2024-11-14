import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart';

@immutable
class CurrentLocationModel {
  final String userCurrLoc;
  final String userCurrCity;
  final String userCurrSubDistrict;
  final Placemark userFullPLacemark;
  final double latitude;
  final double longitude;

  const CurrentLocationModel({
    required this.userCurrLoc,
    required this.userCurrCity,
    required this.userCurrSubDistrict,
    required this.userFullPLacemark,
    required this.latitude,
    required this.longitude,
  });

  CurrentLocationModel copyWith({
    String? userCurrLoc,
    String? userCurrCity,
    String? userCurrSubDistrict,
    Placemark? userFullPLacemark,
    double? latitude,
    double? longitude,
  }) {
    return CurrentLocationModel(
      userCurrLoc: userCurrLoc ?? this.userCurrLoc,
      userCurrCity: userCurrCity ?? this.userCurrCity,
      userCurrSubDistrict: userCurrSubDistrict ?? this.userCurrSubDistrict,
      userFullPLacemark: userFullPLacemark ?? this.userFullPLacemark,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userCurrLoc': userCurrLoc,
      'userCurrCity': userCurrCity,
      'userCurrSubDistrict': userCurrSubDistrict,
      'userFullPLacemark': userFullPLacemark,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory CurrentLocationModel.fromMap(Map<String, dynamic> map) {
    return CurrentLocationModel(
      userCurrLoc: map['userCurrLoc'] as String,
      userCurrCity: map['userCurrCity'] as String,
      userCurrSubDistrict: map['userCurrSubDistrict'] as String,
      userFullPLacemark:
          Placemark.fromMap(map['userFullPLacemark'] as Map<String, dynamic>),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentLocationModel.fromJson(String source) =>
      CurrentLocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentLocationModel(userCurrLoc: $userCurrLoc, userCurrCity: $userCurrCity, userCurrSubDistrict: $userCurrSubDistrict, userFullPLacemark: $userFullPLacemark, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant CurrentLocationModel other) {
    if (identical(this, other)) return true;

    return other.userCurrLoc == userCurrLoc &&
        other.userCurrCity == userCurrCity &&
        other.userCurrSubDistrict == userCurrSubDistrict &&
        other.userFullPLacemark == userFullPLacemark &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return userCurrLoc.hashCode ^
        userCurrCity.hashCode ^
        userCurrSubDistrict.hashCode ^
        userFullPLacemark.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
