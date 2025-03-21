import 'package:flutter/foundation.dart';

import 'package:kualiva/_data/model/pagination/pagination.dart';

@immutable
abstract class MyPage<T> {
  final List<T> data;

  final Pagination pagination;

  const MyPage({
    required this.data,
    required this.pagination,
  });

  @override
  String toString() => 'Page(data: $data, pagination: $pagination)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyPage<T> &&
        listEquals(other.data, data) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => data.hashCode ^ pagination.hashCode;
}
