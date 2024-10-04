// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CuisineModel {
  final int totalItem;
  final List<String> listTitle;
  final List<String> listCuisineLight;
  final List<String> listCuisineDark;
  final List<String> listCuisineBg;

  CuisineModel({
    required this.totalItem,
    required this.listTitle,
    required this.listCuisineLight,
    required this.listCuisineDark,
    required this.listCuisineBg,
  });

  CuisineModel copyWith({
    int? totalItem,
    List<String>? listTitle,
    List<String>? listCuisineLight,
    List<String>? listCuisineDark,
    List<String>? listCuisineBg,
  }) {
    return CuisineModel(
      totalItem: totalItem ?? this.totalItem,
      listTitle: listTitle ?? this.listTitle,
      listCuisineLight: listCuisineLight ?? this.listCuisineLight,
      listCuisineDark: listCuisineDark ?? this.listCuisineDark,
      listCuisineBg: listCuisineBg ?? this.listCuisineBg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalItem': totalItem,
      'listTitle': listTitle,
      'listCuisineLight': listCuisineLight,
      'listCuisineDark': listCuisineDark,
      'listCuisineBg': listCuisineBg,
    };
  }

  factory CuisineModel.fromMap(Map<String, dynamic> map) {
    return CuisineModel(
      totalItem: map['totalItem'] as int,
      listTitle: List<String>.from((map['listTitle'] as List<String>)),
      listCuisineLight:
          List<String>.from((map['listCuisineLight'] as List<String>)),
      listCuisineDark:
          List<String>.from((map['listCuisineDark'] as List<String>)),
      listCuisineBg: List<String>.from((map['listCuisineBg'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory CuisineModel.fromJson(String source) =>
      CuisineModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CuisineModel(totalItem: $totalItem, listTitle: $listTitle, listCuisineLight: $listCuisineLight, listCuisineDark: $listCuisineDark, listCuisineBg: $listCuisineBg)';
  }

  @override
  bool operator ==(covariant CuisineModel other) {
    if (identical(this, other)) return true;

    return other.totalItem == totalItem &&
        listEquals(other.listTitle, listTitle) &&
        listEquals(other.listCuisineLight, listCuisineLight) &&
        listEquals(other.listCuisineDark, listCuisineDark) &&
        listEquals(other.listCuisineBg, listCuisineBg);
  }

  @override
  int get hashCode {
    return totalItem.hashCode ^
        listTitle.hashCode ^
        listCuisineLight.hashCode ^
        listCuisineDark.hashCode ^
        listCuisineBg.hashCode;
  }
}
