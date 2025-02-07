// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/model/minio/image_model.dart';

@immutable
class ImageUploadModel {
  final int count;
  final String message;
  final List<ImageModel> images;

  const ImageUploadModel({
    required this.count,
    required this.message,
    required this.images,
  });

  ImageUploadModel copyWith({
    int? count,
    String? message,
    List<ImageModel>? images,
  }) {
    return ImageUploadModel(
      count: count ?? this.count,
      message: message ?? this.message,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'message': message,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory ImageUploadModel.fromMap(Map<String, dynamic> map) {
    return ImageUploadModel(
      count: map['count'] as int,
      message: map['message'] as String,
      images: List<ImageModel>.from(
        (map['images'] as List<dynamic>).map(
          (x) => ImageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUploadModel.fromJson(String source) =>
      ImageUploadModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImageUploadModel(count: $count, message: $message, images: $images)';

  @override
  bool operator ==(covariant ImageUploadModel other) {
    if (identical(this, other)) return true;

    return other.count == count &&
        other.message == message &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode => count.hashCode ^ message.hashCode ^ images.hashCode;
}
