// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class OnboardingVerifyingModel {
  final IconData icon;
  final String pageTitle;

  const OnboardingVerifyingModel({
    required this.icon,
    required this.pageTitle,
  });

  OnboardingVerifyingModel copyWith({
    IconData? icon,
    String? pageTitle,
  }) {
    return OnboardingVerifyingModel(
      icon: icon ?? this.icon,
      pageTitle: pageTitle ?? this.pageTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon.codePoint,
      'pageTitle': pageTitle,
    };
  }

  factory OnboardingVerifyingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingVerifyingModel(
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      pageTitle: map['pageTitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingVerifyingModel.fromJson(String source) =>
      OnboardingVerifyingModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OnboardingVerifyingModel(icon: $icon, pageTitle: $pageTitle)';

  @override
  bool operator ==(covariant OnboardingVerifyingModel other) {
    if (identical(this, other)) return true;

    return other.icon == icon && other.pageTitle == pageTitle;
  }

  @override
  int get hashCode => icon.hashCode ^ pageTitle.hashCode;
}
