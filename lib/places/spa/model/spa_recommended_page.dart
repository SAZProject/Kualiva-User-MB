import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/spa/model/spa_recommended_model.dart';

part 'spa_recommended_page.g.dart';

@immutable
@HiveType(typeId: 33)
class SpaRecommendedPage extends MyPage<SpaRecommendedModel> {
  @HiveField(0)
  @override
  final List<SpaRecommendedModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const SpaRecommendedPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  SpaRecommendedPage copyWith({
    List<SpaRecommendedModel>? data,
    Pagination? pagination,
  }) {
    return SpaRecommendedPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory SpaRecommendedPage.fromMap(Map<String, dynamic> map) {
    return SpaRecommendedPage(
      data: List<SpaRecommendedModel>.from(
          map['data']?.map((x) => SpaRecommendedModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
