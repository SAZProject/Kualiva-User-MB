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
  final String description;

  @HiveField(2)
  final double rating;

  @HiveField(3)
  final List<String> photoFiles;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  @HiveField(6)
  final AuthorModel author;

  const ReviewPlaceModel({
    required this.id,
    required this.description,
    required this.rating,
    required this.photoFiles,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  ReviewPlaceModel copyWith({
    int? id,
    String? description,
    double? rating,
    List<String>? photoFiles,
    DateTime? createdAt,
    DateTime? updatedAt,
    AuthorModel? author,
  }) {
    return ReviewPlaceModel(
      id: id ?? this.id,
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
      description: map['description'] as String,
      rating: (map['rating']).toDouble(),
      photoFiles: (map['photoFiles'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
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
    return 'ReviewPlaceModel(id: $id, description: $description, rating: $rating, photoFiles: $photoFiles, createdAt: $createdAt, updatedAt: $updatedAt, author: $author)';
  }

  @override
  bool operator ==(covariant ReviewPlaceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
        description.hashCode ^
        rating.hashCode ^
        photoFiles.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        author.hashCode;
  }
}
