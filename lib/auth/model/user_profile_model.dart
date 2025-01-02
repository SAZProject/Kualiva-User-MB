// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@immutable
@HiveType(typeId: 5)
class UserProfileModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstname;

  @HiveField(2)
  final String lastname;

  @HiveField(3)
  final String gender;

  @HiveField(4)
  final DateTime birthDate;

  @HiveField(5)
  final String? photoFile;

  const UserProfileModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.birthDate,
    this.photoFile,
  });

  UserProfileModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? gender,
    DateTime? birthDate,
    String? photoFile,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      photoFile: photoFile ?? this.photoFile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'birthDate': birthDate.millisecondsSinceEpoch,
      'photoFile': photoFile,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] as String,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      gender: map['gender'] as String,
      birthDate: DateTime.parse(map['birthDate']),
      photoFile: map['photoFile'] != null ? map['photoFile'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileModel(id: $id, firstname: $firstname, lastname: $lastname, gender: $gender, birthDate: $birthDate, photoFile: $photoFile)';
  }

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.photoFile == photoFile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        photoFile.hashCode;
  }
}
