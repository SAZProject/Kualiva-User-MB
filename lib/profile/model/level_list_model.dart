// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class LevelListModel {
  final IconData levelIcon;
  final String levelLabel;
  final Color levelColor;
  final bool isActive;

  LevelListModel({
    required this.levelIcon,
    required this.levelLabel,
    required this.levelColor,
    required this.isActive,
  });

  LevelListModel copyWith({
    IconData? levelIcon,
    String? levelLabel,
    Color? levelColor,
    bool? isActive,
  }) {
    return LevelListModel(
      levelIcon: levelIcon ?? this.levelIcon,
      levelLabel: levelLabel ?? this.levelLabel,
      levelColor: levelColor ?? this.levelColor,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'levelIcon': levelIcon.codePoint,
      'levelLabel': levelLabel,
      'levelColor': levelColor.value,
      'isActive': isActive,
    };
  }

  factory LevelListModel.fromMap(Map<String, dynamic> map) {
    return LevelListModel(
      levelIcon: IconData(map['levelIcon'] as int, fontFamily: 'MaterialIcons'),
      levelLabel: map['levelLabel'] as String,
      levelColor: Color(map['levelColor'] as int),
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LevelListModel.fromJson(String source) =>
      LevelListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LevelListModel(levelIcon: $levelIcon, levelLabel: $levelLabel, levelColor: $levelColor, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant LevelListModel other) {
    if (identical(this, other)) return true;

    return other.levelIcon == levelIcon &&
        other.levelLabel == levelLabel &&
        other.levelColor == levelColor &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return levelIcon.hashCode ^
        levelLabel.hashCode ^
        levelColor.hashCode ^
        isActive.hashCode;
  }
}
