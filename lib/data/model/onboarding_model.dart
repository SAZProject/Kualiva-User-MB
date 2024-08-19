// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class OnboardingModel {
  final String imageUri;
  final String title;
  final String content;
  final Color pageColor;

  const OnboardingModel({
    required this.imageUri,
    required this.title,
    required this.content,
    required this.pageColor,
  });

  OnboardingModel copyWith({
    String? imageUri,
    String? title,
    String? content,
    Color? pageColor,
  }) {
    return OnboardingModel(
      imageUri: imageUri ?? this.imageUri,
      title: title ?? this.title,
      content: content ?? this.content,
      pageColor: pageColor ?? this.pageColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUri': imageUri,
      'title': title,
      'content': content,
      'pageColor': pageColor.value,
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      imageUri: map['imageUri'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      pageColor: Color(map['pageColor'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) =>
      OnboardingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OnboardingModel(imageUri: $imageUri, title: $title, content: $content, pageColor: $pageColor)';
  }

  @override
  bool operator ==(covariant OnboardingModel other) {
    if (identical(this, other)) return true;

    return other.imageUri == imageUri &&
        other.title == title &&
        other.content == content &&
        other.pageColor == pageColor;
  }

  @override
  int get hashCode {
    return imageUri.hashCode ^
        title.hashCode ^
        content.hashCode ^
        pageColor.hashCode;
  }
}
