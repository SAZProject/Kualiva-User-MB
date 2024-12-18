// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kualiva/report/model/language_explain_model.dart';
import 'package:kualiva/report/model/parameter_detail_model.dart';

@immutable
class ParameterModel {
  final int id;
  final String bizCode;
  final String languageCode;
  final String explain;
  final LanguageExplainModel language;
  final List<ParameterDetailModel> parameterDetails;

  const ParameterModel({
    required this.id,
    required this.bizCode,
    required this.languageCode,
    required this.explain,
    required this.language,
    required this.parameterDetails,
  });

  ParameterModel copyWith({
    int? id,
    String? bizCode,
    String? languageCode,
    String? explain,
    LanguageExplainModel? language,
    List<ParameterDetailModel>? parameterDetails,
  }) {
    return ParameterModel(
      id: id ?? this.id,
      bizCode: bizCode ?? this.bizCode,
      languageCode: languageCode ?? this.languageCode,
      explain: explain ?? this.explain,
      language: language ?? this.language,
      parameterDetails: parameterDetails ?? this.parameterDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bizCode': bizCode,
      'languageCode': languageCode,
      'explain': explain,
      'language': language.toMap(),
      'parameterDetails': parameterDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory ParameterModel.fromMap(Map<String, dynamic> map) {
    return ParameterModel(
      id: map['id'] as int,
      bizCode: map['bizCode'] as String,
      languageCode: map['languageCode'] as String,
      explain: map['explain'] as String,
      language:
          LanguageExplainModel.fromMap(map['language'] as Map<String, dynamic>),
      parameterDetails: (map['parameterDetails'] as List<dynamic>)
          .map((e) => ParameterDetailModel.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ParameterModel.fromJson(String source) =>
      ParameterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParameterModel(id: $id, bizCode: $bizCode, languageCode: $languageCode, explain: $explain, language: $language, parameterDetails: $parameterDetails)';
  }

  @override
  bool operator ==(covariant ParameterModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bizCode == bizCode &&
        other.languageCode == languageCode &&
        other.explain == explain &&
        other.language == language &&
        listEquals(other.parameterDetails, parameterDetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bizCode.hashCode ^
        languageCode.hashCode ^
        explain.hashCode ^
        language.hashCode ^
        parameterDetails.hashCode;
  }
}
