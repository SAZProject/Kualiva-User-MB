import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'pagination': pagination.toMap(),
    };
  }

  factory FnbNearestPage.fromMap(Map<String, dynamic> map) {
    return FnbNearestPage(
      data: List<FnbNearestModel>.from(
          map['data']?.map((x) => FnbNearestModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FnbNearestPage.fromJson(String source) =>
      FnbNearestPage.fromMap(json.decode(source));

  @override
  String toString() => 'FnbNearestPage(data: $data, pagination: $pagination)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FnbNearestPage &&
        listEquals(other.data, data) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => data.hashCode ^ pagination.hashCode;
}
