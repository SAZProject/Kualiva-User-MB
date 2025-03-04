import 'dart:convert';

import 'package:flutter/widgets.dart';

class GetTimeGApiUtilModel {
  final int? hour;
  final int? minute;

  GetTimeGApiUtilModel({
    this.hour,
    this.minute,
  });

  GetTimeGApiUtilModel copyWith({
    ValueGetter<int?>? hour,
    ValueGetter<int?>? minute,
  }) {
    return GetTimeGApiUtilModel(
      hour: hour != null ? hour() : this.hour,
      minute: minute != null ? minute() : this.minute,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  factory GetTimeGApiUtilModel.fromMap(Map<String, dynamic> map) {
    return GetTimeGApiUtilModel(
      hour: map['hour']?.toInt(),
      minute: map['minute']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetTimeGApiUtilModel.fromJson(String source) =>
      GetTimeGApiUtilModel.fromMap(json.decode(source));

  @override
  String toString() => 'GetTimeGApiUtilModel(hour: $hour, minute: $minute)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetTimeGApiUtilModel &&
        other.hour == hour &&
        other.minute == minute;
  }

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;
}
