import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';

part 'nightlife_promo_page.g.dart';

@immutable
@HiveType(typeId: 27)
class NightlifePromoPage extends MyPage<NightlifePromoModel> {
  @HiveField(0)
  @override
  final List<NightlifePromoModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const NightlifePromoPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  NightlifePromoPage copyWith({
    List<NightlifePromoModel>? data,
    Pagination? pagination,
  }) {
    return NightlifePromoPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory NightlifePromoPage.fromMap(Map<String, dynamic> map) {
    return NightlifePromoPage(
      data: List<NightlifePromoModel>.from(
          map['data']?.map((x) => NightlifePromoModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
