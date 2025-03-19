import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Paging {
  final int page;
  final int size;

  const Paging({
    this.page = 1,
    this.size = 3,
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

  factory Paging.fromMap(Map<String, dynamic> map) {
    return Paging(
      page: map['page']?.toInt() ?? 0,
      size: map['size']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Paging.fromJson(String source) => Paging.fromMap(json.decode(source));

  @override
  String toString() => 'Paging(page: $page, size: $size)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Paging && other.page == page && other.size == size;
  }

  @override
  int get hashCode => page.hashCode ^ size.hashCode;
}
