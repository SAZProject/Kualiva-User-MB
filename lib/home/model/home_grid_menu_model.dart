// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class HomeGridMenuModel {
  final String imageUrl;
  final String label;
  final bool isActive;

  const HomeGridMenuModel({
    required this.imageUrl,
    required this.label,
    required this.isActive,
  });

  HomeGridMenuModel copyWith({
    String? imageUrl,
    String? label,
    bool? isActive,
  }) {
    return HomeGridMenuModel(
      imageUrl: imageUrl ?? this.imageUrl,
      label: label ?? this.label,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'label': label,
      'isActive': isActive,
    };
  }

  factory HomeGridMenuModel.fromMap(Map<String, dynamic> map) {
    return HomeGridMenuModel(
      imageUrl: map['imageUrl'] as String,
      label: map['label'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeGridMenuModel.fromJson(String source) =>
      HomeGridMenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HomeGridMenuModel(imageUrl: $imageUrl, label: $label, isActive: $isActive)';

  @override
  bool operator ==(covariant HomeGridMenuModel other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.label == label &&
        other.isActive == isActive;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ label.hashCode ^ isActive.hashCode;
}
