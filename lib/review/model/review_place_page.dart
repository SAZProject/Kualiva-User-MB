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

  factory ReviewPlacePage.fromMap(Map<String, dynamic> map) {
    return ReviewPlacePage(
      data: List<ReviewPlaceModel>.from(
          map['data']?.map((x) => ReviewPlaceModel.fromMap(x))),
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
