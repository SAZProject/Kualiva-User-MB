// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class OnboardingModel {
  final String? imageUri;
  final IconData? icon;
  final String pageTitle;
  final String? pageHint;
  final String? content;
  final Color? pageColor;

  const OnboardingModel({
    this.imageUri,
    this.icon,
    required this.pageTitle,
    this.pageHint,
    this.content,
    this.pageColor,
  });

  OnboardingModel copyWith({
    String? imageUri,
    IconData? icon,
    String? pageTitle,
    String? pageHint,
    String? content,
    Color? pageColor,
  }) {
    return OnboardingModel(
      imageUri: imageUri ?? this.imageUri,
      icon: icon ?? this.icon,
      pageTitle: pageTitle ?? this.pageTitle,
      pageHint: pageHint ?? this.pageHint,
      content: content ?? this.content,
      pageColor: pageColor ?? this.pageColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUri': imageUri,
      'icon': icon?.codePoint,
      'pageTitle': pageTitle,
      'pageHint': pageHint,
      'content': content,
      'pageColor': pageColor?.value,
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      imageUri: map['imageUri'] != null ? map['imageUri'] as String : null,
      icon: map['icon'] != null
          ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons')
          : null,
      pageTitle: map['pageTitle'] as String,
      pageHint: map['pageHint'] != null ? map['pageHint'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      pageColor:
          map['pageColor'] != null ? Color(map['pageColor'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) =>
      OnboardingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OnboardingModel(imageUri: $imageUri, icon: $icon, pageTitle: $pageTitle, pageHint: $pageHint, content: $content, pageColor: $pageColor)';
  }

  @override
  bool operator ==(covariant OnboardingModel other) {
    if (identical(this, other)) return true;

    return other.imageUri == imageUri &&
        other.icon == icon &&
        other.pageTitle == pageTitle &&
        other.pageHint == pageHint &&
        other.content == content &&
        other.pageColor == pageColor;
  }

  @override
  int get hashCode {
    return imageUri.hashCode ^
        icon.hashCode ^
        pageTitle.hashCode ^
        pageHint.hashCode ^
        content.hashCode ^
        pageColor.hashCode;
  }
}
