import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'pagination.g.dart';

@immutable
@HiveType(typeId: 15)
class Pagination {
  @HiveField(0)
  final int size;

  @HiveField(1)
  final int totalCount;

  @HiveField(2)
  final int currentPage;

  @HiveField(3)
  final int? previousPage;

  @HiveField(4)
  final int? nextPage;

  @HiveField(5)
  final int totalPage;

  const Pagination({
    required this.size,
    required this.totalCount,
    required this.currentPage,
    this.previousPage,
    this.nextPage,
    required this.totalPage,
  });

  Pagination copyWith({
    int? size,
    int? totalCount,
    int? currentPage,
    ValueGetter<int?>? previousPage,
    ValueGetter<int?>? nextPage,
    int? totalPage,
  }) {
    return Pagination(
      size: size ?? this.size,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      previousPage: previousPage != null ? previousPage() : this.previousPage,
      nextPage: nextPage != null ? nextPage() : this.nextPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'totalCount': totalCount,
      'currentPage': currentPage,
      'previousPage': previousPage,
      'nextPage': nextPage,
      'totalPage': totalPage,
    };
  }

  factory Pagination.init() {
    return Pagination(
      size: 0,
      totalCount: 0,
      currentPage: 1,
      totalPage: 0,
    );
  }

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      size: map['size']?.toInt() ?? 0,
      totalCount: map['totalCount']?.toInt() ?? 0,
      currentPage: map['currentPage']?.toInt() ?? 0,
      previousPage: map['previousPage']?.toInt(),
      nextPage: map['nextPage']?.toInt(),
      totalPage: map['totalPage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagination.fromJson(String source) =>
      Pagination.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pagination(size: $size, totalCount: $totalCount, currentPage: $currentPage, previousPage: $previousPage, nextPage: $nextPage, totalPage: $totalPage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pagination &&
        other.size == size &&
        other.totalCount == totalCount &&
        other.currentPage == currentPage &&
        other.previousPage == previousPage &&
        other.nextPage == nextPage &&
        other.totalPage == totalPage;
  }

  @override
  int get hashCode {
    return size.hashCode ^
        totalCount.hashCode ^
        currentPage.hashCode ^
        previousPage.hashCode ^
        nextPage.hashCode ^
        totalPage.hashCode;
  }
}
