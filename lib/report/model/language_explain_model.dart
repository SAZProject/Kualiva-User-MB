// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class LanguageExplainModel {
  final String languageCode;
  final String? en;
  final String? id;

  const LanguageExplainModel({
    required this.languageCode,
    this.en,
    this.id,
  });

  LanguageExplainModel copyWith({
    String? languageCode,
    String? en,
    String? id,
  }) {
    return LanguageExplainModel(
      languageCode: languageCode ?? this.languageCode,
      en: en ?? this.en,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'languageCode': languageCode,
      'en': en,
      'id': id,
    };
  }

  factory LanguageExplainModel.fromMap(Map<String, dynamic> map) {
    return LanguageExplainModel(
      languageCode: map['languageCode'] as String,
      en: map['en'] != null ? map['en'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageExplainModel.fromJson(String source) =>
      LanguageExplainModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LanguageExplainModel(languageCode: $languageCode, en: $en, id: $id)';

  @override
  bool operator ==(covariant LanguageExplainModel other) {
    if (identical(this, other)) return true;

    return other.languageCode == languageCode &&
        other.en == en &&
        other.id == id;
  }

  @override
  int get hashCode => languageCode.hashCode ^ en.hashCode ^ id.hashCode;
}
