// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'fnb_nearest_model.g.dart';

@immutable
@HiveType(typeId: 1)
class FnbNearestModel {
  @HiveField(0)
  final String id; // PlaceUniqueId

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double averageRating;

  @HiveField(3)
  final String fullAddress;

  @HiveField(4)
  final List<String> categories;

  @HiveField(5)
  final String? featuredImage;

  const FnbNearestModel({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.fullAddress,
    required this.categories,
    this.featuredImage,
  });

  FnbNearestModel copyWith({
    String? id,
    String? name,
    double? averageRating,
    String? fullAddress,
    List<String>? categories,
    ValueGetter<String?>? featuredImage,
  }) {
    return FnbNearestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      averageRating: averageRating ?? this.averageRating,
      fullAddress: fullAddress ?? this.fullAddress,
      categories: categories ?? this.categories,
      featuredImage:
          featuredImage != null ? featuredImage() : this.featuredImage,
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
    };
  }

  factory FnbNearestModel.fromMap(Map<String, dynamic> map) {
    return FnbNearestModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      averageRating: map['averageRating']?.toDouble() ?? 0.0,
      fullAddress: map['fullAddress'] ?? '',
      categories: List<String>.from(map['categories']),
      featuredImage: map['featuredImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FnbNearestModel.fromJson(String source) =>
      FnbNearestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FnbNearestModel(id: $id, name: $name, averageRating: $averageRating, fullAddress: $fullAddress, categories: $categories, featuredImage: $featuredImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is FnbNearestModel &&
        other.id == id &&
        other.name == name &&
        other.averageRating == averageRating &&
        other.fullAddress == fullAddress &&
        listEquals(other.categories, categories) &&
        other.featuredImage == featuredImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        averageRating.hashCode ^
        fullAddress.hashCode ^
        categories.hashCode ^
        featuredImage.hashCode;
  }
}
