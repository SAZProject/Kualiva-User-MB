import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_model.dart';

part 'nightlife_nearest_page.g.dart';

@immutable
@HiveType(typeId: 21)
class NightlifeNearestPage extends MyPage<NightlifeNearestModel> {
  @HiveField(0)
  @override
  final List<NightlifeNearestModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const NightlifeNearestPage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  NightlifeNearestPage copyWith({
    List<NightlifeNearestModel>? data,
    Pagination? pagination,
  }) {
    return NightlifeNearestPage(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  factory NightlifeNearestPage.fromMap(Map<String, dynamic> map) {
    return NightlifeNearestPage(
      data: List<NightlifeNearestModel>.from(
          map['data']?.map((x) => NightlifeNearestModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
