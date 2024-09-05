// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocDropdownModel {
  final String id;
  final String subdistrict;
  final String city;

  LocDropdownModel({
    required this.id,
    required this.subdistrict,
    required this.city,
  });

  LocDropdownModel copyWith({
    String? id,
    String? subdistrict,
    String? city,
  }) {
    return LocDropdownModel(
      id: id ?? this.id,
      subdistrict: subdistrict ?? this.subdistrict,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subdistrict': subdistrict,
      'city': city,
    };
  }

  factory LocDropdownModel.fromMap(Map<String, dynamic> map) {
    return LocDropdownModel(
      id: map['id'] as String,
      subdistrict: map['subdistrict'] as String,
      city: map['city'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocDropdownModel.fromJson(String source) =>
      LocDropdownModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LocDropdownModel(id: $id, subdistrict: $subdistrict, city: $city)';

  @override
  bool operator ==(covariant LocDropdownModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.subdistrict == subdistrict &&
        other.city == city;
  }

  @override
  int get hashCode => id.hashCode ^ subdistrict.hashCode ^ city.hashCode;
}
