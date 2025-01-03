// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:kualiva/auth/model/user_profile_model.dart';

part 'user_model.g.dart';

@immutable
@HiveType(typeId: 6)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final bool isAdult;

  @HiveField(5)
  final bool isEmailVerified;

  @HiveField(6)
  final bool isPhoneVerified;

  @HiveField(7)
  final bool isGoogle;

  @HiveField(8)
  final DateTime createdAt;

  @HiveField(9)
  final UserProfileModel profile;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.isAdult,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isGoogle,
    required this.createdAt,
    required this.profile,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    bool? isAdult,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isGoogle,
    DateTime? createdAt,
    UserProfileModel? profile,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isAdult: isAdult ?? this.isAdult,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isGoogle: isGoogle ?? this.isGoogle,
      createdAt: createdAt ?? this.createdAt,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'isAdult': isAdult,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'isGoogle': isGoogle,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profile': profile.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      isAdult: map['isAdult'] as bool,
      isEmailVerified: map['isEmailVerified'] as bool,
      isPhoneVerified: map['isPhoneVerified'] as bool,
      isGoogle: map['isGoogle'] as bool,
      createdAt: DateTime.parse(map['createdAt']),
      profile: UserProfileModel.fromMap(map['profile'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, phone: $phone, isAdult: $isAdult, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, isGoogle: $isGoogle, createdAt: $createdAt, profile: $profile)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.phone == phone &&
        other.isAdult == isAdult &&
        other.isEmailVerified == isEmailVerified &&
        other.isPhoneVerified == isPhoneVerified &&
        other.isGoogle == isGoogle &&
        other.createdAt == createdAt &&
        other.profile == profile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        isAdult.hashCode ^
        isEmailVerified.hashCode ^
        isPhoneVerified.hashCode ^
        isGoogle.hashCode ^
        createdAt.hashCode ^
        profile.hashCode;
  }
}
