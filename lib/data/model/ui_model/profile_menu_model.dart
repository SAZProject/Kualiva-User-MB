// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ProfileMenuModel {
  final IconData? icon;
  final String? imageUri;
  final String label;

  ProfileMenuModel({
    this.icon,
    this.imageUri,
    required this.label,
  });

  ProfileMenuModel copyWith({
    IconData? icon,
    String? imageUri,
    String? label,
  }) {
    return ProfileMenuModel(
      icon: icon ?? this.icon,
      imageUri: imageUri ?? this.imageUri,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon?.codePoint,
      'imageUri': imageUri,
      'label': label,
    };
  }

  factory ProfileMenuModel.fromMap(Map<String, dynamic> map) {
    return ProfileMenuModel(
      icon: map['icon'] != null
          ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons')
          : null,
      imageUri: map['imageUri'] != null ? map['imageUri'] as String : null,
      label: map['label'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileMenuModel.fromJson(String source) =>
      ProfileMenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProfileMenuModel(icon: $icon, imageUri: $imageUri, label: $label)';

  @override
  bool operator ==(covariant ProfileMenuModel other) {
    if (identical(this, other)) return true;

    return other.icon == icon &&
        other.imageUri == imageUri &&
        other.label == label;
  }

  @override
  int get hashCode => icon.hashCode ^ imageUri.hashCode ^ label.hashCode;
}
