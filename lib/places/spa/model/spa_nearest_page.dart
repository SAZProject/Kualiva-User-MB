import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/spa/model/spa_nearest_model.dart';

part 'spa_nearest_page.g.dart';

@immutable
@HiveType(typeId: 19)
class SpaNearestPage extends MyPage<SpaNearestModel> {
  @HiveField(0)
  @override
  final List<SpaNearestModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const SpaNearestPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  SpaNearestPage copyWith({
    List<SpaNearestModel>? data,
    Pagination? pagination,
  }) {
    return SpaNearestPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory SpaNearestPage.fromMap(Map<String, dynamic> map) {
    return SpaNearestPage(
      data: List<SpaNearestModel>.from(
          map['data']?.map((x) => SpaNearestModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
