import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class HomeGridMenuModel {
  final String imageUrl;
  final String label;

  const HomeGridMenuModel({
    required this.imageUrl,
    required this.label,
  });

  HomeGridMenuModel copyWith({
    String? imageUrl,
    String? label,
  }) {
    return HomeGridMenuModel(
      imageUrl: imageUrl ?? this.imageUrl,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'label': label,
    };
  }

  factory HomeGridMenuModel.fromMap(Map<String, dynamic> map) {
    return HomeGridMenuModel(
      imageUrl: map['imageUrl'] as String,
      label: map['label'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeGridMenuModel.fromJson(String source) =>
      HomeGridMenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HomeGridMenuModel(imageUrl: $imageUrl, label: $label)';

  @override
  bool operator ==(covariant HomeGridMenuModel other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl && other.label == label;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ label.hashCode;
}
