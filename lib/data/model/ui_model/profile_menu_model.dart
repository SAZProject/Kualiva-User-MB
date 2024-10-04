// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ProfileMenuModel {
  final IconData? icon;
  final String? imageUri;
  final String label;
  final bool isRightIcon;
  final bool isCommingSoon;

  ProfileMenuModel({
    this.icon,
    this.imageUri,
    required this.label,
    required this.isRightIcon,
    required this.isCommingSoon,
  });

  ProfileMenuModel copyWith({
    IconData? icon,
    String? imageUri,
    String? label,
    bool? isRightIcon,
    bool? isCommingSoon,
  }) {
    return ProfileMenuModel(
      icon: icon ?? this.icon,
      imageUri: imageUri ?? this.imageUri,
      label: label ?? this.label,
      isRightIcon: isRightIcon ?? this.isRightIcon,
      isCommingSoon: isCommingSoon ?? this.isCommingSoon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon?.codePoint,
      'imageUri': imageUri,
      'label': label,
      'isRightIcon': isRightIcon,
      'isCommingSoon': isCommingSoon,
    };
  }

  factory ProfileMenuModel.fromMap(Map<String, dynamic> map) {
    return ProfileMenuModel(
      icon: map['icon'] != null
          ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons')
          : null,
      imageUri: map['imageUri'] != null ? map['imageUri'] as String : null,
      label: map['label'] as String,
      isRightIcon: map['isRightIcon'] as bool,
      isCommingSoon: map['isCommingSoon'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileMenuModel.fromJson(String source) =>
      ProfileMenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileMenuModel(icon: $icon, imageUri: $imageUri, label: $label, isRightIcon: $isRightIcon, isCommingSoon: $isCommingSoon)';
  }

  @override
  bool operator ==(covariant ProfileMenuModel other) {
    if (identical(this, other)) return true;

    return other.icon == icon &&
        other.imageUri == imageUri &&
        other.label == label &&
        other.isRightIcon == isRightIcon &&
        other.isCommingSoon == isCommingSoon;
  }

  @override
  int get hashCode {
    return icon.hashCode ^
        imageUri.hashCode ^
        label.hashCode ^
        isRightIcon.hashCode ^
        isCommingSoon.hashCode;
  }
}
