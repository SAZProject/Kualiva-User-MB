// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class FiltersModel {
  final double rating;
  final String priceRange;
  final List<String> facilities;
  final List<String> categories;

  const FiltersModel({
    required this.rating,
    required this.priceRange,
    required this.facilities,
    required this.categories,
  });

  FiltersModel copyWith({
    double? rating,
    String? priceRange,
    List<String>? facilities,
    List<String>? categories,
  }) {
    return FiltersModel(
      rating: rating ?? this.rating,
      priceRange: priceRange ?? this.priceRange,
      facilities: facilities ?? this.facilities,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'priceRange': priceRange,
      'facilities': facilities,
      'categories': categories,
    };
  }

  factory FiltersModel.fromMap(Map<String, dynamic> map) {
    return FiltersModel(
      rating: map['rating'] as double,
      priceRange: map['priceRange'] as String,
      facilities: List<String>.from((map['facilities'] as List<String>)),
      categories: List<String>.from((map['categories'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory FiltersModel.fromJson(String source) =>
      FiltersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FiltersModel(rating: $rating, priceRange: $priceRange, facilities: $facilities, categories: $categories)';
  }

  @override
  bool operator ==(covariant FiltersModel other) {
    if (identical(this, other)) return true;

    return other.rating == rating &&
        other.priceRange == priceRange &&
        listEquals(other.facilities, facilities) &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode {
    return rating.hashCode ^
        priceRange.hashCode ^
        facilities.hashCode ^
        categories.hashCode;
  }
}
