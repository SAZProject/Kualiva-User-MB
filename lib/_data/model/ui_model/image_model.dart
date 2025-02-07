import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class UIImageModel {
  final String id;
  final String uuid;
  final String name;
  final String url;

  const UIImageModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.url,
  });

  UIImageModel copyWith({
    String? id,
    String? uuid,
    String? name,
    String? url,
  }) {
    return UIImageModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uuid': uuid,
      'name': name,
      'url': url,
    };
  }

  factory UIImageModel.fromMap(Map<String, dynamic> map) {
    return UIImageModel(
      id: map['id'] as String,
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UIImageModel.fromJson(String source) =>
      UIImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UIImageModel(id: $id, uuid: $uuid, name: $name, url: $url)';
  }

  @override
  bool operator ==(covariant UIImageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uuid == uuid &&
        other.name == name &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^ uuid.hashCode ^ name.hashCode ^ url.hashCode;
  }
}
