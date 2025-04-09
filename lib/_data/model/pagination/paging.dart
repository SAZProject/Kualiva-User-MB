import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';

@immutable
class Paging {
  final int page;
  final int size;

  const Paging({
    this.page = 1,
    this.size = 15,
  });

  Paging copyWith({
    int? page,
    int? size,
  }) {
    return Paging(
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'size': size,
    };
  }

  bool canNextPage(Pagination pagination) {
    return page >= pagination.totalPage;
  }

  factory Paging.fromMap(Map<String, dynamic> map) {
    return Paging(
      page: map['page']?.toInt() ?? 0,
      size: map['size']?.toInt() ?? 0,
    );
  }

  factory Paging.fromPaginationCurrent(Pagination pagination) {
    return Paging(
      page: pagination.currentPage,
      size: pagination.size,
    );
  }

  factory Paging.fromPaginationNext(Pagination pagination) {
    return Paging(
      page: pagination.nextPage ?? pagination.totalPage,
      size: pagination.size,
    );
  }

  factory Paging.fromPaging(Paging paging) {
    return Paging(
      page: paging.page,
      size: paging.size,
    );
  }

  String toJson() => json.encode(toMap());

  factory Paging.fromJson(String source) => Paging.fromMap(json.decode(source));

  @override
  String toString() => 'Paging(page: $page, size: $size)';
}
