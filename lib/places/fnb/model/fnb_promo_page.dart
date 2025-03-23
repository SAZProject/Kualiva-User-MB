import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';

part 'fnb_promo_page.g.dart';

@immutable
@HiveType(typeId: 23)
class FnbPromoPage extends MyPage<FnbPromoModel> {
  @HiveField(0)
  @override
  final List<FnbPromoModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const FnbPromoPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  FnbPromoPage copyWith({
    List<FnbPromoModel>? data,
    Pagination? pagination,
  }) {
    return FnbPromoPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'pagination': pagination.toMap(),
    };
  }

  factory FnbPromoPage.fromMap(Map<String, dynamic> map) {
    return FnbPromoPage(
      data: List<FnbPromoModel>.from(
          map['data']?.map((x) => FnbPromoModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FnbPromoPage.fromJson(String source) =>
      FnbPromoPage.fromMap(json.decode(source));

  @override
  String toString() => 'FnbPromoPage(data: $data, pagination: $pagination)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FnbPromoPage &&
        listEquals(other.data, data) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => data.hashCode ^ pagination.hashCode;
}
