// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@immutable
@HiveType(typeId: 3)
class ReviewPlaceModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String invoice;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double rating;
  @HiveField(4)
  final List<String> photoFiles;
  @HiveField(5)
  final String createdAt;
  @HiveField(6)
  final String updatedAt;
  @HiveField(7)
  final Author author;

  const ReviewPlaceModel({
    required this.id,
    required this.invoice,
    required this.description,
    required this.rating,
    required this.photoFiles,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  ReviewPlaceModel copyWith({
    int? id,
    String? invoice,
    String? description,
    double? rating,
    List<String>? photoFiles,
    String? createdAt,
    String? updatedAt,
    Author? author,
  }) {
    return ReviewPlaceModel(
      id: id ?? this.id,
      invoice: invoice ?? this.invoice,
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
      'invoice': invoice,
      'description': description,
      'rating': rating,
      'photoFiles': photoFiles,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'author': author.toMap(),
    };
  }

  factory ReviewPlaceModel.fromMap(Map<String, dynamic> map) {
    return ReviewPlaceModel(
      id: map['id'] as int,
      invoice: map['invoice'] as String,
      description: map['description'] as String,
      rating: map['rating'] as double,
      photoFiles: List<String>.from((map['photoFiles'] as List<String>)),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      author: Author.fromMap(map['author'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewPlaceModel.fromJson(String source) =>
      ReviewPlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewPlaceModel(id: $id, invoice: $invoice, description: $description, rating: $rating, photoFiles: $photoFiles, createdAt: $createdAt, updatedAt: $updatedAt, author: $author)';
  }

  @override
  bool operator ==(covariant ReviewPlaceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.invoice == invoice &&
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
        invoice.hashCode ^
        description.hashCode ^
        rating.hashCode ^
        photoFiles.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        author.hashCode;
  }
}

class Author {
  final String userId;
  final String username;
  final String? photoFile;

  Author({
    required this.userId,
    required this.username,
    this.photoFile,
  });

  Author copyWith({
    String? userId,
    String? username,
    String? photoFile,
  }) {
    return Author(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      photoFile: photoFile ?? this.photoFile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'photoFile': photoFile,
    };
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      userId: map['userId'] as String,
      username: map['username'] as String,
      photoFile: map['photoFile'] != null ? map['photoFile'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) =>
      Author.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Author(userId: $userId, username: $username, photoFile: $photoFile)';

  @override
  bool operator ==(covariant Author other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.username == username &&
        other.photoFile == photoFile;
  }

  @override
  int get hashCode => userId.hashCode ^ username.hashCode ^ photoFile.hashCode;
}
