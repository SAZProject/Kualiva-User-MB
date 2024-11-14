// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// Define the main model class for the FnbDetailModel
@immutable
class FnbDetailModel {
  final List<AddressComponent> addressComponents;
  final String formattedAddress;
  final String formattedPhoneNumber;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String internationalPhoneNumber;
  final String name;
  final List<Photo> photos;
  final String placeId;
  final int? priceLevel;
  final String reference;
  final bool businessStatus;
  final bool openNow;
  final bool? delivery;
  final bool dineIn;
  final double rating;
  final String website;
  final String url;
  final List<Review> reviews;
  final List<String> types;
  final Geometry geometry;
  final CurrentOpeningHours currentOpeningHours;

  const FnbDetailModel({
    required this.addressComponents,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.internationalPhoneNumber,
    required this.name,
    required this.photos,
    required this.placeId,
    required this.priceLevel,
    required this.reference,
    required this.businessStatus,
    required this.openNow,
    required this.delivery,
    required this.dineIn,
    required this.rating,
    required this.website,
    required this.url,
    required this.reviews,
    required this.types,
    required this.geometry,
    required this.currentOpeningHours,
  });

  // Factory constructor to create an instance from a Map
  factory FnbDetailModel.fromMap(Map<String, dynamic> map) {
    return FnbDetailModel(
      addressComponents: (map['address_components'] as List<dynamic>)
          .map((e) => AddressComponent.fromMap(e))
          .toList(),
      formattedAddress: map['formatted_address'],
      formattedPhoneNumber: map['formatted_phone_number'],
      icon: map['icon'],
      iconBackgroundColor: map['icon_background_color'],
      iconMaskBaseUri: map['icon_mask_base_uri'],
      internationalPhoneNumber: map['international_phone_number'],
      name: map['name'],
      photos: (map['photos'] as List<dynamic>)
          .map((e) => Photo.fromMap(e))
          .toList(),
      placeId: map['place_id'],
      priceLevel: map['price_level'],
      reference: map['reference'],
      businessStatus: map['business_status'] == 'OPERATIONAL',
      openNow: map['opening_hours']['open_now'],
      delivery: map['delivery'] as bool?,
      dineIn: map['dine_in'],
      rating: (map['rating']).toDouble(),
      website: map['website'] ?? '',
      url: map['url'],
      reviews: List<Review>.from(
          map['reviews'].map((review) => Review.fromMap(review))),
      types: (map['types'] as List<dynamic>).map((e) => e.toString()).toList(),
      geometry: Geometry.fromMap(map['geometry']),
      currentOpeningHours:
          CurrentOpeningHours.fromMap(map['current_opening_hours']),
    );
  }
  @override
  String toString() {
    return 'FnbDetailModel(addressComponents: $addressComponents, formattedAddress: $formattedAddress, formattedPhoneNumber: $formattedPhoneNumber, icon: $icon, iconBackgroundColor: $iconBackgroundColor, iconMaskBaseUri: $iconMaskBaseUri, internationalPhoneNumber: $internationalPhoneNumber, name: $name, photos: $photos, placeId: $placeId, priceLevel: $priceLevel, reference: $reference, businessStatus: $businessStatus, openNow: $openNow, delivery: $delivery, dineIn: $dineIn, rating: $rating, website: $website, url: $url, reviews: $reviews, types: $types, geometry: $geometry, currentOpeningHours: $currentOpeningHours)';
  }

  @override
  bool operator ==(covariant FnbDetailModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.addressComponents, addressComponents) &&
        other.formattedAddress == formattedAddress &&
        other.formattedPhoneNumber == formattedPhoneNumber &&
        other.icon == icon &&
        other.iconBackgroundColor == iconBackgroundColor &&
        other.iconMaskBaseUri == iconMaskBaseUri &&
        other.internationalPhoneNumber == internationalPhoneNumber &&
        other.name == name &&
        listEquals(other.photos, photos) &&
        other.placeId == placeId &&
        other.priceLevel == priceLevel &&
        other.reference == reference &&
        other.businessStatus == businessStatus &&
        other.openNow == openNow &&
        other.delivery == delivery &&
        other.dineIn == dineIn &&
        other.rating == rating &&
        other.website == website &&
        other.url == url &&
        listEquals(other.reviews, reviews) &&
        listEquals(other.types, types) &&
        other.geometry == geometry &&
        other.currentOpeningHours == currentOpeningHours;
  }

  @override
  int get hashCode {
    return addressComponents.hashCode ^
        formattedAddress.hashCode ^
        formattedPhoneNumber.hashCode ^
        icon.hashCode ^
        iconBackgroundColor.hashCode ^
        iconMaskBaseUri.hashCode ^
        internationalPhoneNumber.hashCode ^
        name.hashCode ^
        photos.hashCode ^
        placeId.hashCode ^
        priceLevel.hashCode ^
        reference.hashCode ^
        businessStatus.hashCode ^
        openNow.hashCode ^
        delivery.hashCode ^
        dineIn.hashCode ^
        rating.hashCode ^
        website.hashCode ^
        url.hashCode ^
        reviews.hashCode ^
        types.hashCode ^
        geometry.hashCode ^
        currentOpeningHours.hashCode;
  }
}

@immutable
class Photo {
  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  const Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'height': height,
      'htmlAttributions': htmlAttributions,
      'photoReference': photoReference,
      'width': width,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      height: map['height'] as int,
      htmlAttributions: (map['html_attributions'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      photoReference: map['photo_reference'] as String,
      width: map['width'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Photo.fromJson(String source) =>
      Photo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Photo(height: $height, htmlAttributions: $htmlAttributions, photoReference: $photoReference, width: $width)';
  }

  @override
  bool operator ==(covariant Photo other) {
    if (identical(this, other)) return true;

    return other.height == height &&
        listEquals(other.htmlAttributions, htmlAttributions) &&
        other.photoReference == photoReference &&
        other.width == width;
  }

  @override
  int get hashCode {
    return height.hashCode ^
        htmlAttributions.hashCode ^
        photoReference.hashCode ^
        width.hashCode;
  }
}

@immutable
class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  const AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromMap(Map<String, dynamic> map) {
    return AddressComponent(
      longName: map['long_name'] as String,
      shortName: map['short_name'] as String,
      types: (map['types'] as List<dynamic>).map((e) => e.toString()).toList(),
      // (map['result']['address_components'] as List<dynamic>)
      //     .map((e) => AddressComponent.fromMap(e))
      //     .toList()
    );
  }

  @override
  String toString() =>
      'AddressComponent(longName: $longName, shortName: $shortName, types: $types)';
}

// Define the Review model class
@immutable
class Review {
  final String authorName;
  final String authorUrl;
  final String profilePhotoUrl;
  final int rating;
  final String text;
  final int time;
  final String relativeTimeDescription;

  // Constructor
  const Review({
    required this.authorName,
    required this.authorUrl,
    required this.profilePhotoUrl,
    required this.rating,
    required this.text,
    required this.time,
    required this.relativeTimeDescription,
  });

  // Factory constructor to create an instance from a Map
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      authorName: map['author_name'],
      authorUrl: map['author_url'],
      profilePhotoUrl: map['profile_photo_url'],
      rating: map['rating'],
      text: map['text'],
      time: map['time'],
      relativeTimeDescription: map['relative_time_description'],
    );
  }
}

// Define the Geometry model class
@immutable
class Geometry {
  final Location location;

  // Constructor
  const Geometry({required this.location});

  // Factory constructor to create an instance from a Map
  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: Location.fromMap(map['location']),
    );
  }
}

// Define the Location model class
@immutable
class Location {
  final double lat;
  final double lng;

  // Constructor
  const Location({required this.lat, required this.lng});

  // Factory constructor to create an instance from a Map
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
    );
  }
}

// Define the CurrentOpeningHours model class
@immutable
class CurrentOpeningHours {
  final bool openNow;
  final List<String> weekdayText;

  // Constructor
  const CurrentOpeningHours({required this.openNow, required this.weekdayText});

  // Factory constructor to create an instance from a Map
  factory CurrentOpeningHours.fromMap(Map<String, dynamic> map) {
    return CurrentOpeningHours(
      openNow: map['open_now'],
      weekdayText: List<String>.from(map['weekday_text']),
    );
  }
}
