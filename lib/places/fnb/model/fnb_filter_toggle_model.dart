// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class FnbFilterToggleModel {
  final int id;
  final bool useIcon;
  final IconData? icon;
  final String label;

  FnbFilterToggleModel({
    required this.id,
    required this.useIcon,
    this.icon,
    required this.label,
  });

  FnbFilterToggleModel copyWith({
    int? id,
    bool? useIcon,
    IconData? icon,
    String? label,
  }) {
    return FnbFilterToggleModel(
      id: id ?? this.id,
      useIcon: useIcon ?? this.useIcon,
      icon: icon ?? this.icon,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'useIcon': useIcon,
      'icon': icon?.codePoint,
      'label': label,
    };
  }

  factory FnbFilterToggleModel.fromMap(Map<String, dynamic> map) {
    return FnbFilterToggleModel(
      id: map['id'] as int,
      useIcon: map['useIcon'] as bool,
      icon: map['icon'] != null
          ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons')
          : null,
      label: map['label'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FnbFilterToggleModel.fromJson(String source) =>
      FnbFilterToggleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FnbFilterToggleModel(id: $id, useIcon: $useIcon, icon: $icon, label: $label)';
  }

  @override
  bool operator ==(covariant FnbFilterToggleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.useIcon == useIcon &&
        other.icon == icon &&
        other.label == label;
  }

  @override
  int get hashCode {
    return id.hashCode ^ useIcon.hashCode ^ icon.hashCode ^ label.hashCode;
  }
}
