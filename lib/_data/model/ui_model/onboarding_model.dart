// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class OnboardingModel {
  final String imageUri;
  final String pageTitle;
  final String content;
  final Color pageColor;

  const OnboardingModel({
    required this.imageUri,
    required this.pageTitle,
    required this.content,
    required this.pageColor,
  });

  OnboardingModel copyWith({
    String? imageUri,
    String? pageTitle,
    String? content,
    Color? pageColor,
  }) {
    return OnboardingModel(
      imageUri: imageUri ?? this.imageUri,
      pageTitle: pageTitle ?? this.pageTitle,
      content: content ?? this.content,
      pageColor: pageColor ?? this.pageColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUri': imageUri,
      'pageTitle': pageTitle,
      'content': content,
      'pageColor': pageColor.toARGB32(),
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      imageUri: map['imageUri'] as String,
      pageTitle: map['pageTitle'] as String,
      content: map['content'] as String,
      pageColor: Color(map['pageColor'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) =>
      OnboardingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OnboardingModel(imageUri: $imageUri, pageTitle: $pageTitle, content: $content, pageColor: $pageColor)';
  }

  @override
  bool operator ==(covariant OnboardingModel other) {
    if (identical(this, other)) return true;

    return other.imageUri == imageUri &&
        other.pageTitle == pageTitle &&
        other.content == content &&
        other.pageColor == pageColor;
  }

  @override
  int get hashCode {
    return imageUri.hashCode ^
        pageTitle.hashCode ^
        content.hashCode ^
        pageColor.hashCode;
  }
}
