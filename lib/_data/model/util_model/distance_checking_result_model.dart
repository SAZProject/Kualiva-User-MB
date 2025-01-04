import 'dart:convert';

import "package:flutter/foundation.dart";

import "package:kualiva/_data/model/ui_model/loc_dropdown_model.dart";

@immutable
class DistanceCheckingResultModel {
  final double distanceBetween;
  final LocDropdownModel closestPlace;

  const DistanceCheckingResultModel({
    required this.distanceBetween,
    required this.closestPlace,
  });

  DistanceCheckingResultModel copyWith({
    double? distanceBetween,
    LocDropdownModel? closestPlace,
  }) {
    return DistanceCheckingResultModel(
      distanceBetween: distanceBetween ?? this.distanceBetween,
      closestPlace: closestPlace ?? this.closestPlace,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'distanceBetween': distanceBetween,
      'closestPlace': closestPlace.toMap(),
    };
  }

  factory DistanceCheckingResultModel.fromMap(Map<String, dynamic> map) {
    return DistanceCheckingResultModel(
      distanceBetween: map['distanceBetween'] as double,
      closestPlace:
          LocDropdownModel.fromMap(map['closestPlace'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DistanceCheckingResultModel.fromJson(String source) =>
      DistanceCheckingResultModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DistanceCheckingResultModel(distanceBetween: $distanceBetween, closestPlace: $closestPlace)';

  @override
  bool operator ==(covariant DistanceCheckingResultModel other) {
    if (identical(this, other)) return true;

    return other.distanceBetween == distanceBetween &&
        other.closestPlace == closestPlace;
  }

  @override
  int get hashCode => distanceBetween.hashCode ^ closestPlace.hashCode;
}
