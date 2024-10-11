import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class ImageModel {
  final String id;
  final String uuid;
  final String name;
  final String url;

  const ImageModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.url,
  });

  ImageModel copyWith({
    String? id,
    String? uuid,
    String? name,
    String? url,
  }) {
    return ImageModel(
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

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as String,
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImageModel(id: $id, uuid: $uuid, name: $name, url: $url)';
  }

  @override
  bool operator ==(covariant ImageModel other) {
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
