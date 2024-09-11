// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CollectionModel {
  final String id;
  final String thumbnail;
  final String label;
  final String content;

  CollectionModel({
    required this.id,
    required this.thumbnail,
    required this.label,
    required this.content,
  });

  CollectionModel copyWith({
    String? id,
    String? thumbnail,
    String? label,
    String? content,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      label: label ?? this.label,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'thumbnail': thumbnail,
      'label': label,
      'content': content,
    };
  }

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      id: map['id'] as String,
      thumbnail: map['thumbnail'] as String,
      label: map['label'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionModel.fromJson(String source) =>
      CollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectionModel(id: $id, thumbnail: $thumbnail, label: $label, content: $content)';
  }

  @override
  bool operator ==(covariant CollectionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.thumbnail == thumbnail &&
        other.label == label &&
        other.content == content;
  }

  @override
  int get hashCode {
    return id.hashCode ^ thumbnail.hashCode ^ label.hashCode ^ content.hashCode;
  }
}
