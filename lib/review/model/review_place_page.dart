import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/review/model/review_place_model.dart';

part 'review_place_page.g.dart';

@immutable
@HiveType(typeId: 16)
class ReviewPlacePage extends MyPage<ReviewPlaceModel> {
  @HiveField(0)
  @override
  final List<ReviewPlaceModel> data;

  @HiveField(1)
  @override
  final Pagination pagination;

  const ReviewPlacePage({
    required this.data,
    required this.pagination,
  }) : super(data: data, pagination: pagination);

  ReviewPlacePage copyWith({
    List<ReviewPlaceModel>? data,
    Pagination? pagination,
  }) {
    return ReviewPlacePage(
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

  factory ReviewPlacePage.fromMap(Map<String, dynamic> map) {
    return ReviewPlacePage(
      data: List<ReviewPlaceModel>.from(
          map['data']?.map((x) => ReviewPlaceModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewPlacePage.fromJson(String source) =>
      ReviewPlacePage.fromMap(json.decode(source));

  @override
  String toString() => 'ReviewPlacePage(data: $data, pagination: $pagination)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewPlacePage &&
        listEquals(other.data, data) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => data.hashCode ^ pagination.hashCode;
}
