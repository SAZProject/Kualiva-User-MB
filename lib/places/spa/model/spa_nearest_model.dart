import 'dart:convert';

import 'package:flutter/foundation.dart';

class SpaNearestModel {
  final String id;
  final String name;
  final double averageRating;
  final String fullAddress;
  final List<String> categories;
  final String? featuredImage;
  final bool isMerchant;

  SpaNearestModel({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.fullAddress,
    required this.categories,
    this.featuredImage,
    required this.isMerchant,
  });

  SpaNearestModel copyWith({
    String? id,
    String? name,
    double? averageRating,
    String? fullAddress,
    List<String>? categories,
    ValueGetter<String?>? featuredImage,
    bool? isMerchant,
  }) {
    return SpaNearestModel(
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

  factory SpaNearestModel.fromMap(Map<String, dynamic> map) {
    return SpaNearestModel(
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

  factory SpaNearestModel.fromJson(String source) =>
      SpaNearestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SpaNearestModel(id: $id, name: $name, averageRating: $averageRating, fullAddress: $fullAddress, categories: $categories, featuredImage: $featuredImage, isMerchant: $isMerchant)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpaNearestModel &&
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
