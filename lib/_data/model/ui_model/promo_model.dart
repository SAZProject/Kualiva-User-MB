// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class PromoModel {
  final String imagePath;
  final String title;
  final String publisher;
  final DateTime date;
  final DateTime from;
  final DateTime to;

  const PromoModel({
    required this.imagePath,
    required this.title,
    required this.publisher,
    required this.date,
    required this.from,
    required this.to,
  });

  PromoModel copyWith({
    String? imagePath,
    String? title,
    String? publisher,
    DateTime? date,
    DateTime? from,
    DateTime? to,
  }) {
    return PromoModel(
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      publisher: publisher ?? this.publisher,
      date: date ?? this.date,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'title': title,
      'publisher': publisher,
      'date': date.millisecondsSinceEpoch,
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
    };
  }

  factory PromoModel.fromMap(Map<String, dynamic> map) {
    return PromoModel(
      imagePath: map['imagePath'] as String,
      title: map['title'] as String,
      publisher: map['publisher'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      from: DateTime.fromMillisecondsSinceEpoch(map['from'] as int),
      to: DateTime.fromMillisecondsSinceEpoch(map['to'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PromoModel.fromJson(String source) =>
      PromoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PromoModel(imagePath: $imagePath, title: $title, publisher: $publisher, date: $date, from: $from, to: $to)';
  }

  @override
  bool operator ==(covariant PromoModel other) {
    if (identical(this, other)) return true;

    return other.imagePath == imagePath &&
        other.title == title &&
        other.publisher == publisher &&
        other.date == date &&
        other.from == from &&
        other.to == to;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        title.hashCode ^
        publisher.hashCode ^
        date.hashCode ^
        from.hashCode ^
        to.hashCode;
  }
}
