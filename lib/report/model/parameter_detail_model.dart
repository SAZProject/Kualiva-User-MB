// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kualiva/report/model/language_explain_model.dart';

@immutable
class ParameterDetailModel {
  final int parameterId;
  final String code;
  final int sequence;
  final String languageCode;
  final bool isActive;
  final String explain;
  final LanguageExplainModel language;

  const ParameterDetailModel({
    required this.parameterId,
    required this.code,
    required this.sequence,
    required this.languageCode,
    required this.isActive,
    required this.explain,
    required this.language,
  });

  ParameterDetailModel copyWith({
    int? parameterId,
    String? code,
    int? sequence,
    String? languageCode,
    bool? isActive,
    String? explain,
    LanguageExplainModel? language,
  }) {
    return ParameterDetailModel(
      parameterId: parameterId ?? this.parameterId,
      code: code ?? this.code,
      sequence: sequence ?? this.sequence,
      languageCode: languageCode ?? this.languageCode,
      isActive: isActive ?? this.isActive,
      explain: explain ?? this.explain,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'parameterId': parameterId,
      'code': code,
      'sequence': sequence,
      'languageCode': languageCode,
      'isActive': isActive,
      'explain': explain,
      'language': language.toMap(),
    };
  }

  factory ParameterDetailModel.fromMap(Map<String, dynamic> map) {
    return ParameterDetailModel(
      parameterId: map['parameterId'] as int,
      code: map['code'] as String,
      sequence: map['sequence'] as int,
      languageCode: map['languageCode'] as String,
      isActive: map['isActive'] as bool,
      explain: map['explain'] as String,
      language:
          LanguageExplainModel.fromMap(map['language'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ParameterDetailModel.fromJson(String source) =>
      ParameterDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParameterDetailModel(parameterId: $parameterId, code: $code, sequence: $sequence, languageCode: $languageCode, isActive: $isActive, explain: $explain, language: $language)';
  }

  @override
  bool operator ==(covariant ParameterDetailModel other) {
    if (identical(this, other)) return true;

    return other.parameterId == parameterId &&
        other.code == code &&
        other.sequence == sequence &&
        other.languageCode == languageCode &&
        other.isActive == isActive &&
        other.explain == explain &&
        other.language == language;
  }

  @override
  int get hashCode {
    return parameterId.hashCode ^
        code.hashCode ^
        sequence.hashCode ^
        languageCode.hashCode ^
        isActive.hashCode ^
        explain.hashCode ^
        language.hashCode;
  }
}
