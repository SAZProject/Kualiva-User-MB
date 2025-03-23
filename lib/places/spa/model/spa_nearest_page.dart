import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'pagination': pagination.toMap(),
    };
  }

  factory SpaNearestPage.fromMap(Map<String, dynamic> map) {
    return SpaNearestPage(
      data: List<SpaNearestModel>.from(
          map['data']?.map((x) => SpaNearestModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpaNearestPage.fromJson(String source) =>
      SpaNearestPage.fromMap(json.decode(source));

  @override
  String toString() => 'SpaNearestPage(data: $data, pagination: $pagination)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpaNearestPage &&
        listEquals(other.data, data) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => data.hashCode ^ pagination.hashCode;
}
