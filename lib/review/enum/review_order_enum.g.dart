// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_order_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewOrderEnumAdapter extends TypeAdapter<ReviewOrderEnum> {
  @override
  final int typeId = 12;

  @override
  ReviewOrderEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReviewOrderEnum.mostLikes;
      case 1:
        return ReviewOrderEnum.recent;
      default:
        return ReviewOrderEnum.mostLikes;
    }
  }

  @override
  void write(BinaryWriter writer, ReviewOrderEnum obj) {
    switch (obj) {
      case ReviewOrderEnum.mostLikes:
        writer.writeByte(0);
        break;
      case ReviewOrderEnum.recent:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewOrderEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
