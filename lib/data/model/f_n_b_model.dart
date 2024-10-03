// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:like_it/data/model/review_model.dart';

class FNBModel {
  final String id;
  final String type;
  final String placeName;
  final double overallRating;
  final List<String> tags;
  final String phoneNumber;
  final String city;
  final String placeAddress;
  final String latitude;
  final String longitude;
  final List<int> operationalDay;
  final List<DateTime> operationalTimeOpen;
  final List<DateTime> operationalTimeClose;
  final String avgPrice;
  final List<String> listPriceFnB;
  final List<String> placePicture;
  final List<String> priceListMenuPicture;
  final int totalReview;
  final double avgRating;
  final List<int> totalRatingPerStar;
  final List<ReviewModel> review;
  final bool isClaimed;

  FNBModel({
    required this.id,
    required this.type,
    required this.placeName,
    required this.overallRating,
    required this.tags,
    required this.phoneNumber,
    required this.city,
    required this.placeAddress,
    required this.latitude,
    required this.longitude,
    required this.operationalDay,
    required this.operationalTimeOpen,
    required this.operationalTimeClose,
    required this.avgPrice,
    required this.listPriceFnB,
    required this.placePicture,
    required this.priceListMenuPicture,
    required this.totalReview,
    required this.avgRating,
    required this.totalRatingPerStar,
    required this.review,
    required this.isClaimed,
  });

  FNBModel copyWith({
    String? id,
    String? type,
    String? placeName,
    double? overallRating,
    List<String>? tags,
    String? phoneNumber,
    String? city,
    String? placeAddress,
    String? latitude,
    String? longitude,
    List<int>? operationalDay,
    List<DateTime>? operationalTimeOpen,
    List<DateTime>? operationalTimeClose,
    String? avgPrice,
    List<String>? listPriceFnB,
    List<String>? placePicture,
    List<String>? priceListMenuPicture,
    int? totalReview,
    double? avgRating,
    List<int>? totalRatingPerStar,
    List<ReviewModel>? review,
    bool? isClaimed,
  }) {
    return FNBModel(
      id: id ?? this.id,
      type: type ?? this.type,
      placeName: placeName ?? this.placeName,
      overallRating: overallRating ?? this.overallRating,
      tags: tags ?? this.tags,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      placeAddress: placeAddress ?? this.placeAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      operationalDay: operationalDay ?? this.operationalDay,
      operationalTimeOpen: operationalTimeOpen ?? this.operationalTimeOpen,
      operationalTimeClose: operationalTimeClose ?? this.operationalTimeClose,
      avgPrice: avgPrice ?? this.avgPrice,
      listPriceFnB: listPriceFnB ?? this.listPriceFnB,
      placePicture: placePicture ?? this.placePicture,
      priceListMenuPicture: priceListMenuPicture ?? this.priceListMenuPicture,
      totalReview: totalReview ?? this.totalReview,
      avgRating: avgRating ?? this.avgRating,
      totalRatingPerStar: totalRatingPerStar ?? this.totalRatingPerStar,
      review: review ?? this.review,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'placeName': placeName,
      'overallRating': overallRating,
      'tags': tags,
      'phoneNumber': phoneNumber,
      'city': city,
      'placeAddress': placeAddress,
      'latitude': latitude,
      'longitude': longitude,
      'operationalDay': operationalDay,
      'operationalTimeOpen':
          operationalTimeOpen.map((x) => x.millisecondsSinceEpoch).toList(),
      'operationalTimeClose':
          operationalTimeClose.map((x) => x.millisecondsSinceEpoch).toList(),
      'avgPrice': avgPrice,
      'listPriceFnB': listPriceFnB,
      'placePicture': placePicture,
      'priceListMenuPicture': priceListMenuPicture,
      'totalReview': totalReview,
      'avgRating': avgRating,
      'totalRatingPerStar': totalRatingPerStar,
      'review': review.map((x) => x.toMap()).toList(),
      'isClaimed': isClaimed,
    };
  }

  factory FNBModel.fromMap(Map<String, dynamic> map) {
    return FNBModel(
      id: map['id'] as String,
      type: map['type'] as String,
      placeName: map['placeName'] as String,
      overallRating: map['overallRating'] as double,
      tags: List<String>.from((map['tags'] as List<String>)),
      phoneNumber: map['phoneNumber'] as String,
      city: map['city'] as String,
      placeAddress: map['placeAddress'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      operationalDay: List<int>.from((map['operationalDay'] as List<int>)),
      operationalTimeOpen: List<DateTime>.from(
        (map['operationalTimeOpen'] as List<int>).map<DateTime>(
          (x) => DateTime.fromMillisecondsSinceEpoch(x),
        ),
      ),
      operationalTimeClose: List<DateTime>.from(
        (map['operationalTimeClose'] as List<int>).map<DateTime>(
          (x) => DateTime.fromMillisecondsSinceEpoch(x),
        ),
      ),
      avgPrice: map['avgPrice'] as String,
      listPriceFnB: List<String>.from((map['listPriceFnB'] as List<String>)),
      placePicture: List<String>.from((map['placePicture'] as List<String>)),
      priceListMenuPicture:
          List<String>.from((map['priceListMenuPicture'] as List<String>)),
      totalReview: map['totalReview'] as int,
      avgRating: map['avgRating'] as double,
      totalRatingPerStar:
          List<int>.from((map['totalRatingPerStar'] as List<int>)),
      review: List<ReviewModel>.from(
        (map['review'] as List<int>).map<ReviewModel>(
          (x) => ReviewModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isClaimed: map['isClaimed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FNBModel.fromJson(String source) =>
      FNBModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FNBModel(id: $id, type: $type, placeName: $placeName, overallRating: $overallRating, tags: $tags, phoneNumber: $phoneNumber, city: $city, placeAddress: $placeAddress, latitude: $latitude, longitude: $longitude, operationalDay: $operationalDay, operationalTimeOpen: $operationalTimeOpen, operationalTimeClose: $operationalTimeClose, avgPrice: $avgPrice, listPriceFnB: $listPriceFnB, placePicture: $placePicture, priceListMenuPicture: $priceListMenuPicture, totalReview: $totalReview, avgRating: $avgRating, totalRatingPerStar: $totalRatingPerStar, review: $review, isClaimed: $isClaimed)';
  }

  @override
  bool operator ==(covariant FNBModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.placeName == placeName &&
        other.overallRating == overallRating &&
        listEquals(other.tags, tags) &&
        other.phoneNumber == phoneNumber &&
        other.city == city &&
        other.placeAddress == placeAddress &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.operationalDay, operationalDay) &&
        listEquals(other.operationalTimeOpen, operationalTimeOpen) &&
        listEquals(other.operationalTimeClose, operationalTimeClose) &&
        other.avgPrice == avgPrice &&
        listEquals(other.listPriceFnB, listPriceFnB) &&
        listEquals(other.placePicture, placePicture) &&
        listEquals(other.priceListMenuPicture, priceListMenuPicture) &&
        other.totalReview == totalReview &&
        other.avgRating == avgRating &&
        listEquals(other.totalRatingPerStar, totalRatingPerStar) &&
        listEquals(other.review, review) &&
        other.isClaimed == isClaimed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        placeName.hashCode ^
        overallRating.hashCode ^
        tags.hashCode ^
        phoneNumber.hashCode ^
        city.hashCode ^
        placeAddress.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        operationalDay.hashCode ^
        operationalTimeOpen.hashCode ^
        operationalTimeClose.hashCode ^
        avgPrice.hashCode ^
        listPriceFnB.hashCode ^
        placePicture.hashCode ^
        priceListMenuPicture.hashCode ^
        totalReview.hashCode ^
        avgRating.hashCode ^
        totalRatingPerStar.hashCode ^
        review.hashCode ^
        isClaimed.hashCode;
  }
}
