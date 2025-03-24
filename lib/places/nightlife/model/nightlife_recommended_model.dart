import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'nightlife_recommended_model.g.dart';

@immutable
@HiveType(typeId: 28)
class NightlifeRecommendedModel {
  @HiveField(0)
  final String id; // PlaceUniqueId

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double averageRating;

  @HiveField(3)
  final String fullAddress;

  @HiveField(4)
  final String cityOrVillage;

  @HiveField(5)
  final List<String> categories;

  @HiveField(6)
  final String? featuredImage;

  @HiveField(7)
  final bool isMerchant;

  @HiveField(8)
  final String distanceFromUser;

  const NightlifeRecommendedModel({
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

  NightlifeRecommendedModel copyWith({
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
    return NightlifeRecommendedModel(
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'averageRating': averageRating,
      'fullAddress': fullAddress,
      'cityOrVillage': cityOrVillage,
      'categories': categories,
      'featuredImage': featuredImage,
      'isMerchant': isMerchant,
      'distanceFromUser': distanceFromUser,
    };
  }

  factory NightlifeRecommendedModel.fromMap(Map<String, dynamic> map) {
    return NightlifeRecommendedModel(
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

  String toJson() => json.encode(toMap());

  factory NightlifeRecommendedModel.fromJson(String source) =>
      NightlifeRecommendedModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NightlifeRecommendedModel(id: $id, name: $name, averageRating: $averageRating, fullAddress: $fullAddress, cityOrVillage: $cityOrVillage, categories: $categories, featuredImage: $featuredImage, isMerchant: $isMerchant, distanceFromUser: $distanceFromUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NightlifeRecommendedModel &&
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
