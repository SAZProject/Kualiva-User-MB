import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';

@immutable
class FnbActionModel {
  final String id;
  final String name;
  final double averageRating;
  final String fullAddress;
  final String cityOrVillage;
  final List<String> categories;
  final String? featuredImage;
  final bool isMerchant;
  final String distanceFromUser;

  const FnbActionModel({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.fullAddress,
    required this.cityOrVillage,
    required this.categories,
    this.featuredImage,
    required this.isMerchant,
    required this.distanceFromUser,
  });

  FnbActionModel copyWith({
    String? id,
    String? name,
    double? averageRating,
    String? fullAddress,
    String? cityOrVillage,
    List<String>? categories,
    ValueGetter<String?>? featuredImage,
    bool? isMerchant,
    String? distanceFromUser,
  }) {
    return FnbActionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      averageRating: averageRating ?? this.averageRating,
      fullAddress: fullAddress ?? this.fullAddress,
      cityOrVillage: cityOrVillage ?? this.cityOrVillage,
      categories: categories ?? this.categories,
      featuredImage:
          featuredImage != null ? featuredImage() : this.featuredImage,
      isMerchant: isMerchant ?? this.isMerchant,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }

  factory FnbActionModel.fromNearestModel(FnbNearestModel data) {
    return FnbActionModel(
      id: data.id,
      name: data.name,
      averageRating: data.averageRating,
      fullAddress: data.fullAddress,
      cityOrVillage: data.cityOrVillage,
      categories: data.categories,
      isMerchant: data.isMerchant,
      distanceFromUser: data.distanceFromUser,
    );
  }

  factory FnbActionModel.fromPromoModel(FnbPromoModel data) {
    return FnbActionModel(
      id: data.id,
      name: data.name,
      averageRating: data.averageRating,
      fullAddress: '',
      cityOrVillage: data.cityOrVillage,
      categories: data.categories,
      isMerchant: true,
      distanceFromUser: data.distanceFromUser,
    );
  }

  // TODO: FnbActionModel.fromRecommendedModel

  factory FnbActionModel.fromMap(Map<String, dynamic> map) {
    return FnbActionModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      averageRating: map['averageRating']?.toDouble() ?? 0.0,
      fullAddress: map['fullAddress'] ?? '',
      cityOrVillage: map['cityOrVillage'] ?? '',
      categories: List<String>.from(map['categories']),
      featuredImage: map['featuredImage'],
      isMerchant: map['isMerchant'] ?? false,
      distanceFromUser: map['distanceFromUser'] ?? '',
    );
  }

  @override
  String toString() {
    return 'FnbActionModel(id: $id, name: $name, averageRating: $averageRating, fullAddress: $fullAddress, cityOrVillage: $cityOrVillage, categories: $categories, featuredImage: $featuredImage, isMerchant: $isMerchant, distanceFromUser: $distanceFromUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FnbActionModel &&
        other.id == id &&
        other.name == name &&
        other.averageRating == averageRating &&
        other.fullAddress == fullAddress &&
        other.cityOrVillage == cityOrVillage &&
        listEquals(other.categories, categories) &&
        other.featuredImage == featuredImage &&
        other.isMerchant == isMerchant &&
        other.distanceFromUser == distanceFromUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        averageRating.hashCode ^
        fullAddress.hashCode ^
        cityOrVillage.hashCode ^
        categories.hashCode ^
        featuredImage.hashCode ^
        isMerchant.hashCode ^
        distanceFromUser.hashCode;
  }
}
