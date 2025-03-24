import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';

part 'fnb_nearest_page.g.dart';

@immutable
@HiveType(typeId: 17)
class FnbNearestPage extends MyPage<FnbNearestModel> {
  @HiveField(0)
  @override
  final List<FnbNearestModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const FnbNearestPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  FnbNearestPage copyWith({
    List<FnbNearestModel>? data,
    Pagination? pagination,
  }) {
    return FnbNearestPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory FnbNearestPage.fromMap(Map<String, dynamic> map) {
    return FnbNearestPage(
      data: List<FnbNearestModel>.from(
          map['data']?.map((x) => FnbNearestModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
