// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FiltersModel {
  double radiusMin;
  double radiusMax;
  double priceRangeMin;
  double priceRangeMax;
  double ratingMin;
  double ratingMax;
  List<String> foodSubCateg;
  List<String> bvgSubCateg;
  FiltersModel({
    required this.radiusMin,
    required this.radiusMax,
    required this.priceRangeMin,
    required this.priceRangeMax,
    required this.ratingMin,
    required this.ratingMax,
    required this.foodSubCateg,
    required this.bvgSubCateg,
  });

  FiltersModel copyWith({
    double? radiusMin,
    double? radiusMax,
    double? priceRangeMin,
    double? priceRangeMax,
    double? ratingMin,
    double? ratingMax,
    List<String>? foodSubCateg,
    List<String>? bvgSubCateg,
  }) {
    return FiltersModel(
      radiusMin: radiusMin ?? this.radiusMin,
      radiusMax: radiusMax ?? this.radiusMax,
      priceRangeMin: priceRangeMin ?? this.priceRangeMin,
      priceRangeMax: priceRangeMax ?? this.priceRangeMax,
      ratingMin: ratingMin ?? this.ratingMin,
      ratingMax: ratingMax ?? this.ratingMax,
      foodSubCateg: foodSubCateg ?? this.foodSubCateg,
      bvgSubCateg: bvgSubCateg ?? this.bvgSubCateg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'radiusMin': radiusMin,
      'radiusMax': radiusMax,
      'priceRangeMin': priceRangeMin,
      'priceRangeMax': priceRangeMax,
      'ratingMin': ratingMin,
      'ratingMax': ratingMax,
      'foodSubCateg': foodSubCateg,
      'bvgSubCateg': bvgSubCateg,
    };
  }

  factory FiltersModel.fromMap(Map<String, dynamic> map) {
    return FiltersModel(
      radiusMin: map['radiusMin'] as double,
      radiusMax: map['radiusMax'] as double,
      priceRangeMin: map['priceRangeMin'] as double,
      priceRangeMax: map['priceRangeMax'] as double,
      ratingMin: map['ratingMin'] as double,
      ratingMax: map['ratingMax'] as double,
      foodSubCateg: List<String>.from((map['foodSubCateg'] as List<String>)),
      bvgSubCateg: List<String>.from((map['bvgSubCateg'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory FiltersModel.fromJson(String source) =>
      FiltersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FiltersModel(radiusMin: $radiusMin, radiusMax: $radiusMax, priceRangeMin: $priceRangeMin, priceRangeMax: $priceRangeMax, ratingMin: $ratingMin, ratingMax: $ratingMax, foodSubCateg: $foodSubCateg, bvgSubCateg: $bvgSubCateg)';
  }

  @override
  bool operator ==(covariant FiltersModel other) {
    if (identical(this, other)) return true;

    return other.radiusMin == radiusMin &&
        other.radiusMax == radiusMax &&
        other.priceRangeMin == priceRangeMin &&
        other.priceRangeMax == priceRangeMax &&
        other.ratingMin == ratingMin &&
        other.ratingMax == ratingMax &&
        listEquals(other.foodSubCateg, foodSubCateg) &&
        listEquals(other.bvgSubCateg, bvgSubCateg);
  }

  @override
  int get hashCode {
    return radiusMin.hashCode ^
        radiusMax.hashCode ^
        priceRangeMin.hashCode ^
        priceRangeMax.hashCode ^
        ratingMin.hashCode ^
        ratingMax.hashCode ^
        foodSubCateg.hashCode ^
        bvgSubCateg.hashCode;
  }
}
