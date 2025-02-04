// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kualiva/_data/model/parameter/language_explain_model.dart';
import 'package:kualiva/_data/model/parameter/parameter_detail_model.dart';

part "parameter_model.g.dart";

@immutable
@HiveType(typeId: 10)
class ParameterModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String div;

  @HiveField(2)
  final String subDiv;

  @HiveField(3)
  final String languageCode;

  @HiveField(4)
  final bool isActive;

  @HiveField(5)
  final String explain;

  @HiveField(7)
  final LanguageExplainModel language;

  @HiveField(8)
  final List<ParameterDetailModel> parameterDetails;

  const ParameterModel({
    required this.id,
    required this.div,
    required this.subDiv,
    required this.languageCode,
    required this.isActive,
    required this.explain,
    required this.language,
    required this.parameterDetails,
  });

  ParameterModel copyWith({
    int? id,
    String? div,
    String? subDiv,
    String? languageCode,
    bool? isActive,
    String? explain,
    LanguageExplainModel? language,
    List<ParameterDetailModel>? parameterDetails,
  }) {
    return ParameterModel(
      id: id ?? this.id,
      div: div ?? this.div,
      subDiv: subDiv ?? this.subDiv,
      languageCode: languageCode ?? this.languageCode,
      isActive: isActive ?? this.isActive,
      explain: explain ?? this.explain,
      language: language ?? this.language,
      parameterDetails: parameterDetails ?? this.parameterDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'div': div,
      'subDiv': subDiv,
      'languageCode': languageCode,
      'isActive': isActive,
      'explain': explain,
      'language': language.toMap(),
      'parameterDetails': parameterDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory ParameterModel.fromMap(Map<String, dynamic> map) {
    return ParameterModel(
      id: map['id'] as int,
      div: map['div'] as String,
      subDiv: map['subDiv'] as String,
      languageCode: map['languageCode'] as String,
      isActive: map['isActive'] as bool,
      explain: map['explain'] as String,
      language:
          LanguageExplainModel.fromMap(map['language'] as Map<String, dynamic>),
      parameterDetails: (map['parameterDetails'] as List<dynamic>)
          .map((x) => ParameterDetailModel.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ParameterModel.fromJson(String source) =>
      ParameterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParameterModel(id: $id, div: $div, subDiv: $subDiv, languageCode: $languageCode, isActive: $isActive, explain: $explain, language: $language, parameterDetails: $parameterDetails)';
  }

  @override
  bool operator ==(covariant ParameterModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.div == div &&
        other.subDiv == subDiv &&
        other.languageCode == languageCode &&
        other.isActive == isActive &&
        other.explain == explain &&
        other.language == language &&
        listEquals(other.parameterDetails, parameterDetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        div.hashCode ^
        subDiv.hashCode ^
        languageCode.hashCode ^
        isActive.hashCode ^
        explain.hashCode ^
        language.hashCode ^
        parameterDetails.hashCode;
  }
}
