// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:kualiva/review/model/author_model.dart';

part 'review_place_model.g.dart';

@immutable
@HiveType(typeId: 4)
class ReviewPlaceModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int? count;

  @HiveField(2)
  final bool? isLikedByMe;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final List<String> photoFiles;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime updatedAt;

  @HiveField(8)
  final AuthorModel author;

  const ReviewPlaceModel({
    required this.id,
    this.count,
    this.isLikedByMe,
    required this.description,
    required this.rating,
    required this.photoFiles,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  ReviewPlaceModel copyWith({
    int? id,
    int? count,
    bool? isLikedByMe,
    String? description,
    double? rating,
    List<String>? photoFiles,
    DateTime? createdAt,
    DateTime? updatedAt,
    AuthorModel? author,
  }) {
    return ReviewPlaceModel(
      id: id ?? this.id,
      count: count ?? this.count,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      photoFiles: photoFiles ?? this.photoFiles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'count': count,
      'isLikedByMe': isLikedByMe,
      'description': description,
      'rating': rating,
      'photoFiles': photoFiles,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'author': author.toMap(),
    };
  }

  factory ReviewPlaceModel.fromMap(Map<String, dynamic> map) {
    return ReviewPlaceModel(
      id: map['id'] as int,
      count: map['count'] != null ? map['count'] as int : null,
      isLikedByMe:
          map['isLikedByMe'] != null ? map['isLikedByMe'] as bool : null,
      description: map['description'] as String,
      rating: (map['rating']).toDouble(),
      photoFiles: List<String>.from((map['photoFiles'] as List<dynamic>)),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      author: AuthorModel.fromMap(map['author'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewPlaceModel.fromJson(String source) =>
      ReviewPlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewPlaceModel(id: $id, count: $count, isLikedByMe: $isLikedByMe, description: $description, rating: $rating, photoFiles: $photoFiles, createdAt: $createdAt, updatedAt: $updatedAt, author: $author)';
  }

  @override
  bool operator ==(covariant ReviewPlaceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.count == count &&
        other.isLikedByMe == isLikedByMe &&
        other.description == description &&
        other.rating == rating &&
        listEquals(other.photoFiles, photoFiles) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        count.hashCode ^
        isLikedByMe.hashCode ^
        description.hashCode ^
        rating.hashCode ^
        photoFiles.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        author.hashCode;
  }
}
