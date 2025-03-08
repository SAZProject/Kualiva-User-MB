// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_selected_user_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewSelectedUserEnumAdapter
    extends TypeAdapter<ReviewSelectedUserEnum> {
  @override
  final int typeId = 11;

  @override
  ReviewSelectedUserEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReviewSelectedUserEnum.user;
      case 1:
        return ReviewSelectedUserEnum.kualiva;
      default:
        return ReviewSelectedUserEnum.user;
    }
  }

  @override
  void write(BinaryWriter writer, ReviewSelectedUserEnum obj) {
    switch (obj) {
      case ReviewSelectedUserEnum.user:
        writer.writeByte(0);
        break;
      case ReviewSelectedUserEnum.kualiva:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewSelectedUserEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
