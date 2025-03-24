import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_model.dart';

part 'nightlife_recommended_page.g.dart';

@immutable
@HiveType(typeId: 29)
class NightlifeRecommendedPage extends MyPage<NightlifeRecommendedModel> {
  @HiveField(0)
  @override
  final List<NightlifeRecommendedModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const NightlifeRecommendedPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  NightlifeRecommendedPage copyWith({
    List<NightlifeRecommendedModel>? data,
    Pagination? pagination,
  }) {
    return NightlifeRecommendedPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory NightlifeRecommendedPage.fromMap(Map<String, dynamic> map) {
    return NightlifeRecommendedPage(
      data: List<NightlifeRecommendedModel>.from(
          map['data']?.map((x) => NightlifeRecommendedModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
