// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilterToggleModel {
  final int id;
  final bool useIcon;
  final IconData? icon;
  final String label;

  FilterToggleModel({
    required this.id,
    required this.useIcon,
    this.icon,
    required this.label,
  });

  FilterToggleModel copyWith({
    int? id,
    bool? useIcon,
    ValueGetter<IconData?>? icon,
    String? label,
  }) {
    return FilterToggleModel(
      id: id ?? this.id,
      useIcon: useIcon ?? this.useIcon,
      icon: icon != null ? icon() : this.icon,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'useIcon': useIcon,
      'icon': icon?.codePoint,
      'label': label,
    };
  }

  factory FilterToggleModel.fromMap(Map<String, dynamic> map) {
    return FilterToggleModel(
      id: map['id']?.toInt() ?? 0,
      useIcon: map['useIcon'] ?? false,
      icon: map['icon'] != null
          ? IconData(map['icon'], fontFamily: 'MaterialIcons')
          : null,
      label: map['label'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterToggleModel.fromJson(String source) =>
      FilterToggleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FilterToggleModel(id: $id, useIcon: $useIcon, icon: $icon, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterToggleModel &&
        other.id == id &&
        other.useIcon == useIcon &&
        other.icon == icon &&
        other.label == label;
  }

  @override
  int get hashCode {
    return id.hashCode ^ useIcon.hashCode ^ icon.hashCode ^ label.hashCode;
  }
}
