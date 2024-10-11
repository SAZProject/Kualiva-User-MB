import 'dart:convert';
import 'package:like_it/data/model/ui_model/image_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class ReviewModel {
  final String id;
  final String username;
  final ImageModel userImage;
  final DateTime reviewDate;
  final double rating;
  final String content;
  final bool specialReview;

  const ReviewModel({
    required this.id,
    required this.username,
    required this.userImage,
    required this.reviewDate,
    required this.rating,
    required this.content,
    required this.specialReview,
  });

  ReviewModel copyWith({
    String? id,
    String? username,
    ImageModel? userImage,
    DateTime? reviewDate,
    double? rating,
    String? content,
    bool? specialReview,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      username: username ?? this.username,
      userImage: userImage ?? this.userImage,
      reviewDate: reviewDate ?? this.reviewDate,
      rating: rating ?? this.rating,
      content: content ?? this.content,
      specialReview: specialReview ?? this.specialReview,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'userImage': userImage.toMap(),
      'reviewDate': reviewDate.millisecondsSinceEpoch,
      'rating': rating,
      'content': content,
      'specialReview': specialReview,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] as String,
      username: map['username'] as String,
      userImage: ImageModel.fromMap(map['userImage'] as Map<String, dynamic>),
      reviewDate: DateTime.fromMillisecondsSinceEpoch(map['reviewDate'] as int),
      rating: map['rating'] as double,
      content: map['content'] as String,
      specialReview: map['specialReview'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewModel(id: $id, username: $username, userImage: $userImage, reviewDate: $reviewDate, rating: $rating, content: $content, specialReview: $specialReview)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.userImage == userImage &&
        other.reviewDate == reviewDate &&
        other.rating == rating &&
        other.content == content &&
        other.specialReview == specialReview;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        userImage.hashCode ^
        reviewDate.hashCode ^
        rating.hashCode ^
        content.hashCode ^
        specialReview.hashCode;
  }
}
