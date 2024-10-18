// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class RestaurantExtractorModel {
  final String name;
  final String? description;
  final String fullAddress;
  final String municipality;
  final String categories;
  final String timeZone;
  final String phones;
  final String claimed;
  final int reviewCount;
  final double averageRating;
  final String reviewUrl;
  final String googleMapsUrl;
  final double latitude;
  final double longitude;
  final String? website;
  final String? domain;
  final String openingHours;
  final String featuredImages;
  final String cid;
  final String fid;
  final String placeId;

  const RestaurantExtractorModel({
    required this.name,
    required this.description,
    required this.fullAddress,
    required this.municipality,
    required this.categories,
    required this.timeZone,
    required this.phones,
    required this.claimed,
    required this.reviewCount,
    required this.averageRating,
    required this.reviewUrl,
    required this.googleMapsUrl,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.domain,
    required this.openingHours,
    required this.featuredImages,
    required this.cid,
    required this.fid,
    required this.placeId,
  });

  factory RestaurantExtractorModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return RestaurantExtractorModel(
      name: map['name'] as String,
      description: map['description'] as String?,
      fullAddress: map['fulladdress'] as String,
      municipality: map['municipality'] as String,
      categories: map['categories'] as String,
      timeZone: map['timeZone'] as String,
      phones: map['phones'] as String,
      claimed: map['claimed'] as String,
      reviewCount: map['reviewCount'] as int,
      averageRating: double.parse(map['averageRating'].toString()),
      reviewUrl: map['reviewURL'] as String,
      googleMapsUrl: map['googleMapsURL'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      website: map['website'] as String?,
      domain: map['domain'] as String?,
      openingHours: map['openingHours'] as String,
      featuredImages: map['featuredImage'] as String,
      cid: map['cid'] as String,
      fid: map['fid'] as String,
      placeId: map['placeId'] as String,
    );
  }
  factory RestaurantExtractorModel.fromJson(String source) =>
      RestaurantExtractorModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RestaurantExtractorModel(name: $name, description: $description, fullAddress: $fullAddress, municipality: $municipality, categories: $categories, timeZone: $timeZone, phones: $phones, claimed: $claimed, reviewCount: $reviewCount, averageRating: $averageRating, reviewUrl: $reviewUrl, googleMapsUrl: $googleMapsUrl, latitude: $latitude, longitude: $longitude, websites: $website, domain: $domain, openingHours: $openingHours, featuredImages: $featuredImages, cid: $cid, fid: $fid, placeId: $placeId)';
  }

  @override
  bool operator ==(covariant RestaurantExtractorModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.fullAddress == fullAddress &&
        other.municipality == municipality &&
        other.categories == categories &&
        other.timeZone == timeZone &&
        other.phones == phones &&
        other.claimed == claimed &&
        other.reviewCount == reviewCount &&
        other.averageRating == averageRating &&
        other.reviewUrl == reviewUrl &&
        other.googleMapsUrl == googleMapsUrl &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.website == website &&
        other.domain == domain &&
        other.openingHours == openingHours &&
        other.featuredImages == featuredImages &&
        other.cid == cid &&
        other.fid == fid &&
        other.placeId == placeId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        fullAddress.hashCode ^
        municipality.hashCode ^
        categories.hashCode ^
        timeZone.hashCode ^
        phones.hashCode ^
        claimed.hashCode ^
        reviewCount.hashCode ^
        averageRating.hashCode ^
        reviewUrl.hashCode ^
        googleMapsUrl.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        website.hashCode ^
        domain.hashCode ^
        openingHours.hashCode ^
        featuredImages.hashCode ^
        cid.hashCode ^
        fid.hashCode ^
        placeId.hashCode;
  }
}
