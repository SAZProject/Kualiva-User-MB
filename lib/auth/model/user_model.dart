// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String id;
  final String? firstname;
  final String? lastname;
  final String username;
  final String? email;
  final String phone;
  final String? pin;
  final DateTime? birthdate;
  final bool isAdult;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isGoogle;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? refreshToken;

  const UserModel({
    required this.id,
    this.firstname,
    this.lastname,
    required this.username,
    this.email,
    required this.phone,
    this.pin,
    this.birthdate,
    required this.isAdult,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isGoogle,
    required this.createdAt,
    required this.updatedAt,
    this.refreshToken,
  });

  UserModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? phone,
    String? pin,
    DateTime? birthdate,
    bool? isAdult,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isGoogle,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? refreshToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      birthdate: birthdate ?? this.birthdate,
      isAdult: isAdult ?? this.isAdult,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isGoogle: isGoogle ?? this.isGoogle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'phone': phone,
      'pin': pin,
      'birthdate': birthdate?.millisecondsSinceEpoch,
      'isAdult': isAdult,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'isGoogle': isGoogle,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'refreshToken': refreshToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      firstname: map['firstname'] != null ? map['firstname'] as String : null,
      lastname: map['lastname'] != null ? map['lastname'] as String : null,
      username: map['username'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] as String,
      pin: map['pin'] != null ? map['pin'] as String : null,
      birthdate: map['birthdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthdate'] as int)
          : null,
      isAdult: map['isAdult'] as bool,
      isEmailVerified: map['isEmailVerified'] as bool,
      isPhoneVerified: map['isPhoneVerified'] as bool,
      isGoogle: map['isGoogle'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname, lastname: $lastname, username: $username, email: $email, phone: $phone, pin: $pin, birthdate: $birthdate, isAdult: $isAdult, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, isGoogle: $isGoogle, createdAt: $createdAt, updatedAt: $updatedAt, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.username == username &&
        other.email == email &&
        other.phone == phone &&
        other.pin == pin &&
        other.birthdate == birthdate &&
        other.isAdult == isAdult &&
        other.isEmailVerified == isEmailVerified &&
        other.isPhoneVerified == isPhoneVerified &&
        other.isGoogle == isGoogle &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        pin.hashCode ^
        birthdate.hashCode ^
        isAdult.hashCode ^
        isEmailVerified.hashCode ^
        isPhoneVerified.hashCode ^
        isGoogle.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        refreshToken.hashCode;
  }
}
