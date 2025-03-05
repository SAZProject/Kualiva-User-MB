import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class NightlifePromoModel {
  final String id; // placeUniqueId

  final String name;

  final int promoPercentage;

  final double averageRating;

  final String cityOrVillage;

  final List<String> categories;

  final String? featuredImage;

  const NightlifePromoModel({
    required this.id,
    required this.name,
    required this.promoPercentage,
    required this.averageRating,
    required this.cityOrVillage,
    required this.categories,
    this.featuredImage,
  });

  NightlifePromoModel copyWith({
    String? id,
    String? name,
    int? promoPercentage,
    double? averageRating,
    String? cityOrVillage,
    List<String>? categories,
    ValueGetter<String?>? featuredImage,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory NightlifePromoModel.fromJson(String source) =>
      NightlifePromoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NightlifePromoModel(id: $id, name: $name, promoPercentage: $promoPercentage, averageRating: $averageRating, cityOrVillage: $cityOrVillage, categories: $categories, featuredImage: $featuredImage)';
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
        other.featuredImage == featuredImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        promoPercentage.hashCode ^
        averageRating.hashCode ^
        cityOrVillage.hashCode ^
        categories.hashCode ^
        featuredImage.hashCode;
  }
}
