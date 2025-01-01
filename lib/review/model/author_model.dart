// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'author_model.g.dart';

@immutable
@HiveType(typeId: 3)
class AuthorModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String? photoFile;

  const AuthorModel({
    required this.userId,
    required this.username,
    this.photoFile,
  });

  AuthorModel copyWith({
    String? userId,
    String? username,
    String? photoFile,
  }) {
    return AuthorModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      photoFile: photoFile ?? this.photoFile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'photoFile': photoFile,
    };
  }

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      userId: map['userId'] as String,
      username: map['username'] as String,
      photoFile: map['photoFile'] != null ? map['photoFile'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthorModel(userId: $userId, username: $username, photoFile: $photoFile)';

  @override
  bool operator ==(covariant AuthorModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.username == username &&
        other.photoFile == photoFile;
  }

  @override
  int get hashCode => userId.hashCode ^ username.hashCode ^ photoFile.hashCode;
}
