// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kualiva/_data/model/parameter/language_explain_model.dart';

part 'parameter_detail_model.g.dart';

@immutable
@HiveType(typeId: 9)
class ParameterDetailModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int parameterId;

  @HiveField(2)
  final int sequence;

  @HiveField(3)
  final String languageCode;

  @HiveField(4)
  final bool isActive;

  @HiveField(5)
  final String explain;

  @HiveField(6)
  final String? image;

  @HiveField(7)
  final LanguageExplainModel language;

  const ParameterDetailModel({
    required this.id,
    required this.parameterId,
    required this.sequence,
    required this.languageCode,
    required this.isActive,
    required this.explain,
    this.image,
    required this.language,
  });

  ParameterDetailModel copyWith({
    int? id,
    int? parameterId,
    int? sequence,
    String? languageCode,
    bool? isActive,
    String? explain,
    String? image,
    LanguageExplainModel? language,
  }) {
    return ParameterDetailModel(
      id: id ?? this.id,
      parameterId: parameterId ?? this.parameterId,
      sequence: sequence ?? this.sequence,
      languageCode: languageCode ?? this.languageCode,
      isActive: isActive ?? this.isActive,
      explain: explain ?? this.explain,
      image: image ?? this.image,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'parameterId': parameterId,
      'sequence': sequence,
      'languageCode': languageCode,
      'isActive': isActive,
      'explain': explain,
      'image': image,
      'language': language.toMap(),
    };
  }

  factory ParameterDetailModel.fromMap(Map<String, dynamic> map) {
    return ParameterDetailModel(
      id: map['id'] as int,
      parameterId: map['parameterId'] as int,
      sequence: map['sequence'] as int,
      languageCode: map['languageCode'] as String,
      isActive: map['isActive'] as bool,
      explain: map['explain'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      language:
          LanguageExplainModel.fromMap(map['language'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ParameterDetailModel.fromJson(String source) =>
      ParameterDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParameterDetailModel(id: $id, parameterId: $parameterId, sequence: $sequence, languageCode: $languageCode, isActive: $isActive, explain: $explain, image: $image, language: $language)';
  }

  @override
  bool operator ==(covariant ParameterDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.parameterId == parameterId &&
        other.sequence == sequence &&
        other.languageCode == languageCode &&
        other.isActive == isActive &&
        other.explain == explain &&
        other.image == image &&
        other.language == language;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parameterId.hashCode ^
        sequence.hashCode ^
        languageCode.hashCode ^
        isActive.hashCode ^
        explain.hashCode ^
        image.hashCode ^
        language.hashCode;
  }
}
