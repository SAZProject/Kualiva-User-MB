import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_model.dart';

part 'fnb_recommended_page.g.dart';

@immutable
@HiveType(typeId: 25)
class FnbRecommendedPage extends MyPage<FnbRecommendedModel> {
  @HiveField(0)
  @override
  final List<FnbRecommendedModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const FnbRecommendedPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  FnbRecommendedPage copyWith({
    List<FnbRecommendedModel>? data,
    Pagination? pagination,
  }) {
    return FnbRecommendedPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory FnbRecommendedPage.fromMap(Map<String, dynamic> map) {
    return FnbRecommendedPage(
      data: List<FnbRecommendedModel>.from(
          map['data']?.map((x) => FnbRecommendedModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
