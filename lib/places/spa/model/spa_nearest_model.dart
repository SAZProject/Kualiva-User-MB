import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'spa_nearest_model.g.dart';

@immutable
@HiveType(typeId: 18)
class SpaNearestModel {
  @HiveField(0)
  final String id;

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

  @HiveField(6)
  final bool isMerchant;

  @HiveField(7)
  final String distanceFromUser;

  const SpaNearestModel({
    required this.id,
    required this.name,
    required this.averageRating,
    required this.fullAddress,
    required this.categories,
    this.featuredImage,
    required this.isMerchant,
    required this.distanceFromUser,
  });

  SpaNearestModel copyWith({
    String? id,
    String? name,
    double? averageRating,
    String? fullAddress,
    List<String>? categories,
    ValueGetter<String?>? featuredImage,
    bool? isMerchant,
    String? distanceFromUser,
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
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
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
      'distanceFromUser': distanceFromUser,
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
      distanceFromUser: map['distanceFromUser'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SpaNearestModel.fromJson(String source) =>
      SpaNearestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SpaNearestModel(id: $id, name: $name, averageRating: $averageRating, fullAddress: $fullAddress, categories: $categories, featuredImage: $featuredImage, isMerchant: $isMerchant, distanceFromUser: $distanceFromUser)';
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
        other.isMerchant == isMerchant &&
        other.distanceFromUser == distanceFromUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        averageRating.hashCode ^
        fullAddress.hashCode ^
        categories.hashCode ^
        featuredImage.hashCode ^
        isMerchant.hashCode ^
        distanceFromUser.hashCode;
  }
}
