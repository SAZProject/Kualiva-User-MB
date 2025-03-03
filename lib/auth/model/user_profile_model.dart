// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@immutable
@HiveType(typeId: 5)
class UserProfileModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? fullName;

  @HiveField(2)
  final String? gender;

  @HiveField(3)
  final DateTime? birthDate;

  @HiveField(4)
  final String? photoFile;

  const UserProfileModel({
    required this.id,
    this.fullName,
    this.gender,
    this.birthDate,
    this.photoFile,
  });

  UserProfileModel copyWith({
    String? id,
    ValueGetter<String?>? fullName,
    ValueGetter<String?>? gender,
    ValueGetter<DateTime?>? birthDate,
    ValueGetter<String?>? photoFile,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      fullName: fullName != null ? fullName() : this.fullName,
      gender: gender != null ? gender() : this.gender,
      birthDate: birthDate != null ? birthDate() : this.birthDate,
      photoFile: photoFile != null ? photoFile() : this.photoFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'gender': gender,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'photoFile': photoFile,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] ?? '',
      fullName: map['fullName'],
      gender: map['gender'],
      birthDate:
          map['birthDate'] != null ? DateTime.parse(map['birthDate']) : null,
      photoFile: map['photoFile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, fullName: $fullName, gender: $gender, birthDate: $birthDate, photoFile: $photoFile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfileModel &&
        other.id == id &&
        other.fullName == fullName &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.photoFile == photoFile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        photoFile.hashCode;
  }
}
