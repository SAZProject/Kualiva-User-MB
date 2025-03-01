import 'dart:convert';

import 'package:flutter/foundation.dart';

class NightlifeNearestModel {
  final String id;
  final String name;
  final double averageRating;
  final String fullAddress;
  final List<String> categories;
  final String? featuredImage;
  final bool isMerchant;

  NightlifeNearestModel({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.fullAddress,
    required this.categories,
    this.featuredImage,
    required this.isMerchant,
  });

  NightlifeNearestModel copyWith({
    String? id,
    String? name,
    double? averageRating,
    String? fullAddress,
    List<String>? categories,
    ValueGetter<String?>? featuredImage,
    bool? isMerchant,
  }) {
    return NightlifeNearestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      averageRating: averageRating ?? this.averageRating,
      fullAddress: fullAddress ?? this.fullAddress,
      categories: categories ?? this.categories,
      featuredImage:
          featuredImage != null ? featuredImage() : this.featuredImage,
      isMerchant: isMerchant ?? this.isMerchant,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'averageRating': averageRating,
      'fullAddress': fullAddress,
      'categories': categories,
      'featuredImage': featuredImage,
      'isMerchant': isMerchant,
    };
  }

  factory NightlifeNearestModel.fromMap(Map<String, dynamic> map) {
    return NightlifeNearestModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      averageRating: map['averageRating']?.toDouble() ?? 0.0,
      fullAddress: map['fullAddress'] ?? '',
      categories: List<String>.from(map['categories']),
      featuredImage: map['featuredImage'],
      isMerchant: map['isMerchant'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NightlifeNearestModel.fromJson(String source) =>
      NightlifeNearestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NightlifeNearestModel(id: $id, name: $name, averageRating: $averageRating, fullAddress: $fullAddress, categories: $categories, featuredImage: $featuredImage, isMerchant: $isMerchant)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NightlifeNearestModel &&
        other.id == id &&
        other.name == name &&
        other.averageRating == averageRating &&
        other.fullAddress == fullAddress &&
        listEquals(other.categories, categories) &&
        other.featuredImage == featuredImage &&
        other.isMerchant == isMerchant;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        averageRating.hashCode ^
        fullAddress.hashCode ^
        categories.hashCode ^
        featuredImage.hashCode ^
        isMerchant.hashCode;
  }
}
