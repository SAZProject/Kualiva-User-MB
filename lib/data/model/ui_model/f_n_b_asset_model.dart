// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FNBAssetModel {
  final int totalItem;
  final List<String> listTitle;
  final List<String> listAssetLight;
  final List<String> listAssetDark;
  final List<String>? listAssetBg;

  FNBAssetModel({
    required this.totalItem,
    required this.listTitle,
    required this.listAssetLight,
    required this.listAssetDark,
    this.listAssetBg,
  });

  FNBAssetModel copyWith({
    int? totalItem,
    List<String>? listTitle,
    List<String>? listAssetLight,
    List<String>? listAssetDark,
    List<String>? listAssetBg,
  }) {
    return FNBAssetModel(
      totalItem: totalItem ?? this.totalItem,
      listTitle: listTitle ?? this.listTitle,
      listAssetLight: listAssetLight ?? this.listAssetLight,
      listAssetDark: listAssetDark ?? this.listAssetDark,
      listAssetBg: listAssetBg ?? this.listAssetBg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalItem': totalItem,
      'listTitle': listTitle,
      'listAssetLight': listAssetLight,
      'listAssetDark': listAssetDark,
      'listAssetBg': listAssetBg,
    };
  }

  factory FNBAssetModel.fromMap(Map<String, dynamic> map) {
    return FNBAssetModel(
      totalItem: map['totalItem'] as int,
      listTitle: List<String>.from((map['listTitle'] as List<String>)),
      listAssetLight:
          List<String>.from((map['listAssetLight'] as List<String>)),
      listAssetDark: List<String>.from((map['listAssetDark'] as List<String>)),
      listAssetBg: map['listAssetBg'] != null
          ? List<String>.from((map['listAssetBg'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FNBAssetModel.fromJson(String source) =>
      FNBAssetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FNBAssetModel(totalItem: $totalItem, listTitle: $listTitle, listAssetLight: $listAssetLight, listAssetDark: $listAssetDark, listAssetBg: $listAssetBg)';
  }

  @override
  bool operator ==(covariant FNBAssetModel other) {
    if (identical(this, other)) return true;

    return other.totalItem == totalItem &&
        listEquals(other.listTitle, listTitle) &&
        listEquals(other.listAssetLight, listAssetLight) &&
        listEquals(other.listAssetDark, listAssetDark) &&
        listEquals(other.listAssetBg, listAssetBg);
  }

  @override
  int get hashCode {
    return totalItem.hashCode ^
        listTitle.hashCode ^
        listAssetLight.hashCode ^
        listAssetDark.hashCode ^
        listAssetBg.hashCode;
  }
}
