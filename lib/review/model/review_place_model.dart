// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:kualiva/review/model/author_model.dart';

part 'review_place_model.g.dart';

@immutable
@HiveType(typeId: 4)
class ReviewPlaceModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? invoice;

  @HiveField(2)
  final String? invoiceFile;

  @HiveField(3)
  final int? count;

  @HiveField(4)
  final bool? isLikedByMe;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final double rating;

  @HiveField(7)
  final List<String> photoFiles;

  @HiveField(8)
  final DateTime createdAt;

  @HiveField(9)
  final DateTime updatedAt;

  @HiveField(10)
  final AuthorModel author;

  const ReviewPlaceModel({
    required this.id,
    this.invoice,
    this.invoiceFile,
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
    ValueGetter<String?>? invoice,
    ValueGetter<String?>? invoiceFile,
    ValueGetter<int?>? count,
    ValueGetter<bool?>? isLikedByMe,
    String? description,
    double? rating,
    List<String>? photoFiles,
    DateTime? createdAt,
    DateTime? updatedAt,
    AuthorModel? author,
  }) {
    return ReviewPlaceModel(
      id: id ?? this.id,
      invoice: invoice != null ? invoice() : this.invoice,
      invoiceFile: invoiceFile != null ? invoiceFile() : this.invoiceFile,
      count: count != null ? count() : this.count,
      isLikedByMe: isLikedByMe != null ? isLikedByMe() : this.isLikedByMe,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      photoFiles: photoFiles ?? this.photoFiles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoice': invoice,
      'invoiceFile': invoiceFile,
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
      id: map['id']?.toInt() ?? 0,
      invoice: map['invoice'],
      invoiceFile: map['invoiceFile'],
      count: map['count']?.toInt(),
      isLikedByMe: map['isLikedByMe'],
      description: map['description'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      photoFiles: List<String>.from(map['photoFiles']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      author: AuthorModel.fromMap(map['author']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewPlaceModel.fromJson(String source) =>
      ReviewPlaceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewPlaceModel(id: $id, invoice: $invoice, invoiceFile: $invoiceFile, count: $count, isLikedByMe: $isLikedByMe, description: $description, rating: $rating, photoFiles: $photoFiles, createdAt: $createdAt, updatedAt: $updatedAt, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewPlaceModel &&
        other.id == id &&
        other.invoice == invoice &&
        other.invoiceFile == invoiceFile &&
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
        invoice.hashCode ^
        invoiceFile.hashCode ^
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
