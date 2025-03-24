import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/spa/model/spa_promo_model.dart';

part 'spa_promo_page.g.dart';

@immutable
@HiveType(typeId: 31)
class SpaPromoPage extends MyPage<SpaPromoModel> {
  @HiveField(0)
  @override
  final List<SpaPromoModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const SpaPromoPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  SpaPromoPage copyWith({
    List<SpaPromoModel>? data,
    Pagination? pagination,
  }) {
    return SpaPromoPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory SpaPromoPage.fromMap(Map<String, dynamic> map) {
    return SpaPromoPage(
      data: List<SpaPromoModel>.from(
          map['data']?.map((x) => SpaPromoModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
