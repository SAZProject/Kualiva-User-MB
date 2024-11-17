// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class HomeFeaturedModel {
  final String id;
  final HomeFeaturedLocation location;
  final String name;
  final String fullAddress;
  final String street;
  final String municipality;
  final List<String> categories;
  final String timezone;
  final String? phone;
  final List<String> phones;
  final String claimed;
  final int reviewCount;
  final double averageRating;
  final String? reviewUrl;
  final String googleMapsUrl;
  final double latitude;
  final double longitude;
  final String website;
  final String openingHours;
  final String? featuredImage;
  final String cid;
  final String fid;
  final String placeId;

  const HomeFeaturedModel({
    required this.id,
    required this.location,
    required this.name,
    required this.fullAddress,
    required this.street,
    required this.municipality,
    required this.categories,
    required this.timezone,
    required this.phone,
    required this.phones,
    required this.claimed,
    required this.reviewCount,
    required this.averageRating,
    required this.reviewUrl,
    required this.googleMapsUrl,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.openingHours,
    required this.featuredImage,
    required this.cid,
    required this.fid,
    required this.placeId,
  });

  HomeFeaturedModel copyWith({
    String? id,
    HomeFeaturedLocation? location,
    String? name,
    String? fullAddress,
    String? street,
    String? municipality,
    List<String>? categories,
    String? timezone,
    String? phone,
    List<String>? phones,
    String? claimed,
    int? reviewCount,
    double? averageRating,
    String? reviewUrl,
    String? googleMapsUrl,
    double? latitude,
    double? longitude,
    String? website,
    String? openingHours,
    String? featuredImage,
    String? cid,
    String? fid,
    String? placeId,
  }) {
    return HomeFeaturedModel(
      id: id ?? this.id,
      location: location ?? this.location,
      name: name ?? this.name,
      fullAddress: fullAddress ?? this.fullAddress,
      street: street ?? this.street,
      municipality: municipality ?? this.municipality,
      categories: categories ?? this.categories,
      timezone: timezone ?? this.timezone,
      phone: phone ?? this.phone,
      phones: phones ?? this.phones,
      claimed: claimed ?? this.claimed,
      reviewCount: reviewCount ?? this.reviewCount,
      averageRating: averageRating ?? this.averageRating,
      reviewUrl: reviewUrl ?? this.reviewUrl,
      googleMapsUrl: googleMapsUrl ?? this.googleMapsUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      website: website ?? this.website,
      openingHours: openingHours ?? this.openingHours,
      featuredImage: featuredImage ?? this.featuredImage,
      cid: cid ?? this.cid,
      fid: fid ?? this.fid,
      placeId: placeId ?? this.placeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'location': location.toMap(),
      'name': name,
      'fullAddress': fullAddress,
      'street': street,
      'municipality': municipality,
      'categories': categories,
      'timeZone': timezone,
      'phone': phone,
      'phones': phones,
      'claimed': claimed,
      'reviewCount': reviewCount,
      'averageRating': averageRating,
      'reviewUrl': reviewUrl,
      'googleMapsUrl': googleMapsUrl,
      'latitude': latitude,
      'longitude': longitude,
      'openingHours': openingHours,
      'featuredImage': featuredImage,
      'cid': cid,
      'fid': fid,
      'placeId': placeId,
    };
  }

  factory HomeFeaturedModel.fromMap(Map<String, dynamic> map) {
    return HomeFeaturedModel(
      id: map['_id'] as String,
      location:
          HomeFeaturedLocation.fromMap(map['location'] as Map<String, dynamic>),
      name: map['name'] as String,
      fullAddress: map['fullAddress'] as String,
      street: map['street'] as String,
      municipality: map['municipality'] as String,
      categories: (map['categories'] as String).split(','),
      timezone: map['timezone'] as String,
      phone: map['phone'] as String?,
      phones: (map['phones'] as String).split(','),
      claimed: map['claimed'] as String,
      reviewCount: int.parse(map['reviewCount'].toString()),
      averageRating: double.parse(map['averageRating'].toString()),
      reviewUrl: map['reviewURL'] as String?,
      googleMapsUrl: map['googleMapsURL'] as String,
      latitude: double.parse(map['latitude'].toString()),
      longitude: double.parse(map['longitude'].toString()),
      website: map['website'] as String,
      openingHours: map['openingHours'] as String,
      featuredImage: map['featuredImage'] as String?,
      cid: (map['cid']).toString(), //double.parse(map['cid']).toString(),
      fid: map['fid'] as String,
      placeId: map['placeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeFeaturedModel.fromJson(String source) =>
      HomeFeaturedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeFeaturedModel(id: $id, location: $location, name: $name, fullAddress: $fullAddress, street: $street, municipality: $municipality, categories: $categories, timezone: $timezone, phone: $phone, phones: $phones, claimed: $claimed, reviewCount: $reviewCount, averageRating: $averageRating, reviewUrl: $reviewUrl, googleMapsUrl: $googleMapsUrl, latitude: $latitude, longitude: $longitude, openingHours: $openingHours, featuredImage: $featuredImage, cid: $cid, fid: $fid, placeId: $placeId)';
  }

  @override
  bool operator ==(covariant HomeFeaturedModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.location == location &&
        other.name == name &&
        other.fullAddress == fullAddress &&
        other.street == street &&
        other.municipality == municipality &&
        listEquals(other.categories, categories) &&
        other.timezone == timezone &&
        other.phone == phone &&
        listEquals(other.phones, phones) &&
        other.claimed == claimed &&
        other.reviewCount == reviewCount &&
        other.averageRating == averageRating &&
        other.reviewUrl == reviewUrl &&
        other.googleMapsUrl == googleMapsUrl &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.openingHours == openingHours &&
        other.featuredImage == featuredImage &&
        other.cid == cid &&
        other.fid == fid &&
        other.placeId == placeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        location.hashCode ^
        name.hashCode ^
        fullAddress.hashCode ^
        street.hashCode ^
        municipality.hashCode ^
        categories.hashCode ^
        timezone.hashCode ^
        phone.hashCode ^
        phones.hashCode ^
        claimed.hashCode ^
        reviewCount.hashCode ^
        averageRating.hashCode ^
        reviewUrl.hashCode ^
        googleMapsUrl.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        openingHours.hashCode ^
        featuredImage.hashCode ^
        cid.hashCode ^
        fid.hashCode ^
        placeId.hashCode;
  }
}

@immutable
class HomeFeaturedLocation {
  final String type;
  final List<double> coordinates;

  const HomeFeaturedLocation({
    required this.type,
    required this.coordinates,
  });

  HomeFeaturedLocation copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return HomeFeaturedLocation(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory HomeFeaturedLocation.fromMap(Map<String, dynamic> map) {
    return HomeFeaturedLocation(
      type: map['type'] as String,
      coordinates: (map['coordinates'] as List<dynamic>)
          .map((e) => e as double)
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeFeaturedLocation.fromJson(String source) =>
      HomeFeaturedLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HomeFeaturedLocation(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(covariant HomeFeaturedLocation other) {
    if (identical(this, other)) return true;

    return other.type == type && listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}
