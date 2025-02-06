// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class ImageModel {
  final String fileName;
  final String imageUrl;
  final String pathUrl;

  const ImageModel({
    required this.fileName,
    required this.imageUrl,
    required this.pathUrl,
  });

  ImageModel copyWith({
    String? fileName,
    String? imageUrl,
    String? pathUrl,
  }) {
    return ImageModel(
      fileName: fileName ?? this.fileName,
      imageUrl: imageUrl ?? this.imageUrl,
      pathUrl: pathUrl ?? this.pathUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName,
      'imageUrl': imageUrl,
      'pathUrl': pathUrl,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      fileName: map['fileName'] as String,
      imageUrl: map['imageUrl'] as String,
      pathUrl: map['pathUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImageModel(fileName: $fileName, imageUrl: $imageUrl, pathUrl: $pathUrl)';

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;

    return other.fileName == fileName &&
        other.imageUrl == imageUrl &&
        other.pathUrl == pathUrl;
  }

  @override
  int get hashCode => fileName.hashCode ^ imageUrl.hashCode ^ pathUrl.hashCode;
}
