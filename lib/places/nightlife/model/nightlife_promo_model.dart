import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'nightlife_promo_model.g.dart';

@immutable
@HiveType(typeId: 26)
class NightlifePromoModel {
  @HiveField(0)
  final String id; // placeUniqueId

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int promoPercentage;

  @HiveField(3)
  final double averageRating;

  @HiveField(4)
  final String cityOrVillage;

  @HiveField(5)
  final List<String> categories;

  @HiveField(6)
  final String? featuredImage;

  @HiveField(7)
  final String distanceFromUser;

  const NightlifePromoModel({
    required this.id,
    required this.name,
    required this.promoPercentage,
    required this.averageRating,
    required this.cityOrVillage,
    required this.categories,
    this.featuredImage,
    required this.distanceFromUser,
  });

  NightlifePromoModel copyWith({
    String? id,
    String? name,
    int? promoPercentage,
    double? averageRating,
    String? cityOrVillage,
    List<String>? categories,
    ValueGetter<String?>? featuredImage,
    String? distanceFromUser,
  }) {
    return NightlifePromoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      promoPercentage: promoPercentage ?? this.promoPercentage,
      averageRating: averageRating ?? this.averageRating,
      cityOrVillage: cityOrVillage ?? this.cityOrVillage,
      categories: categories ?? this.categories,
      featuredImage:
          featuredImage != null ? featuredImage() : this.featuredImage,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'promoPercentage': promoPercentage,
      'averageRating': averageRating,
      'cityOrVillage': cityOrVillage,
      'categories': categories,
      'featuredImage': featuredImage,
      'distanceFromUser': distanceFromUser,
    };
  }

  factory NightlifePromoModel.fromMap(Map<String, dynamic> map) {
    return NightlifePromoModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      promoPercentage: map['promoPercentage']?.toInt() ?? 0,
      averageRating: map['averageRating']?.toDouble() ?? 0.0,
      cityOrVillage: map['cityOrVillage'] ?? '',
      categories: List<String>.from(map['categories']),
      featuredImage: map['featuredImage'],
      distanceFromUser: map['distanceFromUser'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NightlifePromoModel.fromJson(String source) =>
      NightlifePromoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NightlifePromoModel(id: $id, name: $name, promoPercentage: $promoPercentage, averageRating: $averageRating, cityOrVillage: $cityOrVillage, categories: $categories, featuredImage: $featuredImage, distanceFromUser: $distanceFromUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NightlifePromoModel &&
        other.id == id &&
        other.name == name &&
        other.promoPercentage == promoPercentage &&
        other.averageRating == averageRating &&
        other.cityOrVillage == cityOrVillage &&
        listEquals(other.categories, categories) &&
        other.featuredImage == featuredImage &&
        other.distanceFromUser == distanceFromUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        promoPercentage.hashCode ^
        averageRating.hashCode ^
        cityOrVillage.hashCode ^
        categories.hashCode ^
        featuredImage.hashCode ^
        distanceFromUser.hashCode;
  }
}
