// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fullName == other.fullName &&
          gender == other.gender &&
          birthDate == other.birthDate &&
          photoFile == other.photoFile);

  @override
  int get hashCode =>
      id.hashCode ^
      fullName.hashCode ^
      gender.hashCode ^
      birthDate.hashCode ^
      photoFile.hashCode;

  @override
  String toString() {
    return 'UserProfileModel{' +
        ' id: $id,' +
        ' fullName: $fullName,' +
        ' gender: $gender,' +
        ' birthDate: $birthDate,' +
        ' photoFile: $photoFile,' +
        '}';
  }

  UserProfileModel copyWith({
    String? id,
    String? fullName,
    String? gender,
    DateTime? birthDate,
    String? photoFile,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      photoFile: photoFile ?? this.photoFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fullName': this.fullName,
      'gender': this.gender,
      'birthDate': this.birthDate,
      'photoFile': this.photoFile,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String?,
      gender: map['gender'] as String?,
      birthDate: map['birthDate'] as DateTime?,
      photoFile: map['photoFile'] as String?,
    );
  }
}
