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

  factory FnbPromoPage.fromMap(Map<String, dynamic> map) {
    return FnbPromoPage(
      data: List<FnbPromoModel>.from(
          map['data']?.map((x) => FnbPromoModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
