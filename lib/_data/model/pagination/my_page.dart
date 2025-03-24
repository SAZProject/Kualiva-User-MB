import 'package:flutter/foundation.dart';

import 'package:kualiva/_data/model/pagination/pagination.dart';

@immutable
abstract class MyPage<T> {
  final Pagination pagination;

  final List<T> data;

  const MyPage({
    required this.pagination,
    required this.data,
  });

  @override
  String toString() =>
      'Page(length: ${data.length}, pagination: $pagination, data: $data)';

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
