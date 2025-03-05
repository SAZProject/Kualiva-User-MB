import 'dart:convert';

import 'package:flutter/foundation.dart';

class SpaDetailModel {
  final List<AddressComponent>? addressComponents;
  final String? formattedAddress;
  final String? formattedPhoneNumber;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? internationalPhoneNumber;
  final String? name;
  final List<Photo>? photos;
  final String? placeId;
  final int? priceLevel;
  final String? reference;
  final bool? businessStatus;
  final bool? openNow;
  final bool? delivery;
  final bool? dineIn;
  final double? rating;
  final String? website;
  final String? url;
  final List<Review>? reviews;
  final List<String>? types;
  final Geometry? geometry;
  final CurrentOpeningHours? currentOpeningHours;
  SpaDetailModel({
    this.addressComponents,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    this.name,
    this.photos,
    this.placeId,
    this.priceLevel,
    this.reference,
    this.businessStatus,
    this.openNow,
    this.delivery,
    this.dineIn,
    this.rating,
    this.website,
    this.url,
    this.reviews,
    this.types,
    this.geometry,
    this.currentOpeningHours,
  });

  SpaDetailModel copyWith({
    ValueGetter<List<AddressComponent>?>? addressComponents,
    ValueGetter<String?>? formattedAddress,
    ValueGetter<String?>? formattedPhoneNumber,
    ValueGetter<String?>? icon,
    ValueGetter<String?>? iconBackgroundColor,
    ValueGetter<String?>? iconMaskBaseUri,
    ValueGetter<String?>? internationalPhoneNumber,
    ValueGetter<String?>? name,
    ValueGetter<List<Photo>?>? photos,
    ValueGetter<String?>? placeId,
    ValueGetter<int?>? priceLevel,
    ValueGetter<String?>? reference,
    ValueGetter<bool?>? businessStatus,
    ValueGetter<bool?>? openNow,
    ValueGetter<bool?>? delivery,
    ValueGetter<bool?>? dineIn,
    ValueGetter<double?>? rating,
    ValueGetter<String?>? website,
    ValueGetter<String?>? url,
    ValueGetter<List<Review>?>? reviews,
    ValueGetter<List<String>?>? types,
    ValueGetter<Geometry?>? geometry,
    ValueGetter<CurrentOpeningHours?>? currentOpeningHours,
  }) {
    return SpaDetailModel(
      addressComponents: addressComponents != null
          ? addressComponents()
          : this.addressComponents,
      formattedAddress:
          formattedAddress != null ? formattedAddress() : this.formattedAddress,
      formattedPhoneNumber: formattedPhoneNumber != null
          ? formattedPhoneNumber()
          : this.formattedPhoneNumber,
      icon: icon != null ? icon() : this.icon,
      iconBackgroundColor: iconBackgroundColor != null
          ? iconBackgroundColor()
          : this.iconBackgroundColor,
      iconMaskBaseUri:
          iconMaskBaseUri != null ? iconMaskBaseUri() : this.iconMaskBaseUri,
      internationalPhoneNumber: internationalPhoneNumber != null
          ? internationalPhoneNumber()
          : this.internationalPhoneNumber,
      name: name != null ? name() : this.name,
      photos: photos != null ? photos() : this.photos,
      placeId: placeId != null ? placeId() : this.placeId,
      priceLevel: priceLevel != null ? priceLevel() : this.priceLevel,
      reference: reference != null ? reference() : this.reference,
      businessStatus:
          businessStatus != null ? businessStatus() : this.businessStatus,
      openNow: openNow != null ? openNow() : this.openNow,
      delivery: delivery != null ? delivery() : this.delivery,
      dineIn: dineIn != null ? dineIn() : this.dineIn,
      rating: rating != null ? rating() : this.rating,
      website: website != null ? website() : this.website,
      url: url != null ? url() : this.url,
      reviews: reviews != null ? reviews() : this.reviews,
      types: types != null ? types() : this.types,
      geometry: geometry != null ? geometry() : this.geometry,
      currentOpeningHours: currentOpeningHours != null
          ? currentOpeningHours()
          : this.currentOpeningHours,
    );
  }

  factory SpaDetailModel.fromMap(Map<String, dynamic> map) {
    return SpaDetailModel(
      addressComponents: map['address_components'] != null
          ? List<AddressComponent>.from(map['address_components']
              ?.map((x) => AddressComponent.fromMap(x)))
          : null,
      formattedAddress: map['formatted_address'],
      formattedPhoneNumber: map['formatted_phone_number'],
      icon: map['icon'],
      iconBackgroundColor: map['icon_background_color'],
      iconMaskBaseUri: map['icon_mask_base_uri'],
      internationalPhoneNumber: map['international_phone_number'],
      name: map['name'],
      photos: map['photos'] != null
          ? List<Photo>.from(map['photos']?.map((x) => Photo.fromMap(x)))
          : null,
      placeId: map['place_id'],
      priceLevel: map['price_level']?.toInt(),
      reference: map['reference'],
      businessStatus: map['business_status'] != null ? true : false,
      openNow: map['open_now'],
      delivery: map['delivery'],
      dineIn: map['dine_in'],
      rating: map['rating']?.toDouble(),
      website: map['website'],
      url: map['url'],
      reviews: map['reviews'] != null
          ? List<Review>.from(map['reviews']?.map((x) => Review.fromMap(x)))
          : null,
      types: List<String>.from(map['types']),
      geometry:
          map['geometry'] != null ? Geometry.fromMap(map['geometry']) : null,
      currentOpeningHours: map['current_opening_hours'] != null
          ? CurrentOpeningHours.fromMap(map['current_opening_hours'])
          : null,
    );
  }

  @override
  String toString() {
    return 'SpaDetailModel(addressComponents: $addressComponents, formattedAddress: $formattedAddress, formattedPhoneNumber: $formattedPhoneNumber, icon: $icon, iconBackgroundColor: $iconBackgroundColor, iconMaskBaseUri: $iconMaskBaseUri, internationalPhoneNumber: $internationalPhoneNumber, name: $name, photos: $photos, placeId: $placeId, priceLevel: $priceLevel, reference: $reference, businessStatus: $businessStatus, openNow: $openNow, delivery: $delivery, dineIn: $dineIn, rating: $rating, website: $website, url: $url, reviews: $reviews, types: $types, geometry: $geometry, currentOpeningHours: $currentOpeningHours)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpaDetailModel &&
        listEquals(other.addressComponents, addressComponents) &&
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
  final NightLifeDetailLocation location;

  // Constructor
  const Geometry({required this.location});

  // Factory constructor to create an instance from a Map
  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: NightLifeDetailLocation.fromMap(map['location']),
    );
  }
}

// Define the NightLifeDetailLocation model class
@immutable
class NightLifeDetailLocation {
  final double lat;
  final double lng;

  // Constructor
  const NightLifeDetailLocation({required this.lat, required this.lng});

  // Factory constructor to create an instance from a Map
  factory NightLifeDetailLocation.fromMap(Map<String, dynamic> map) {
    return NightLifeDetailLocation(
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
  final List<Periods> periods;

  // Constructor
  const CurrentOpeningHours(
      {required this.openNow,
      required this.weekdayText,
      required this.periods});

  // Factory constructor to create an instance from a Map
  factory CurrentOpeningHours.fromMap(Map<String, dynamic> map) {
    return CurrentOpeningHours(
        openNow: map['open_now'],
        weekdayText: List<String>.from(map['weekday_text']),
        periods: List<Periods>.generate((map['periods'] as List).length,
            (index) => Periods.fromMap(map['periods'][index])));
  }

  @override
  String toString() =>
      'CurrentOpeningHours(openNow: $openNow, weekdayText: $weekdayText, periods: $periods)';
}

class Periods {
  final String open;
  final String close;

  // Constructor
  const Periods({required this.open, required this.close});

  // Factory constructor to create an instance from a Map
  factory Periods.fromMap(Map<String, dynamic> map) {
    return Periods(
      open: map['open']['time'],
      close: map['close']['time'],
    );
  }
}
