import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class LocFullAddressModel {
  final String placeName;
  final String addressDetail;
  final double latitude;
  final double longitude;

  const LocFullAddressModel({
    required this.placeName,
    required this.addressDetail,
    required this.latitude,
    required this.longitude,
  });

  LocFullAddressModel copyWith({
    String? placeName,
    String? addressDetail,
    double? latitude,
    double? longitude,
  }) {
    return LocFullAddressModel(
      placeName: placeName ?? this.placeName,
      addressDetail: addressDetail ?? this.addressDetail,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'placeName': placeName,
      'addressDetail': addressDetail,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocFullAddressModel.fromMap(Map<String, dynamic> map) {
    return LocFullAddressModel(
      placeName: map['placeName'] as String,
      addressDetail: map['addressDetail'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocFullAddressModel.fromJson(String source) =>
      LocFullAddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocFullAddressModel(placeName: $placeName, addressDetail: $addressDetail, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant LocFullAddressModel other) {
    if (identical(this, other)) return true;

    return other.placeName == placeName &&
        other.addressDetail == addressDetail &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return placeName.hashCode ^
        addressDetail.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
