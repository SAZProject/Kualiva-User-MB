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

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'pagination': pagination.toMap(),
    };
  }

  factory NightlifeNearestPage.fromMap(Map<String, dynamic> map) {
    return NightlifeNearestPage(
      data: List<NightlifeNearestModel>.from(
          map['data']?.map((x) => NightlifeNearestModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NightlifeNearestPage.fromJson(String source) =>
      NightlifeNearestPage.fromMap(json.decode(source));

  @override
  String toString() =>
      'NightlifeNearestPage(data: $data, pagination: $pagination)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NightlifeNearestPage &&
        listEquals(other.data, data) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => data.hashCode ^ pagination.hashCode;
}
