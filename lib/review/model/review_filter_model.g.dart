// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_filter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewFilterModelAdapter extends TypeAdapter<ReviewFilterModel> {
  @override
  final int typeId = 13;

  @override
  ReviewFilterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewFilterModel(
      selectedUser: fields[0] as ReviewSelectedUserEnum?,
      withMedia: fields[1] as bool?,
      rating: fields[2] as int?,
      order: fields[3] as ReviewOrderEnum?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewFilterModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.selectedUser)
      ..writeByte(1)
      ..write(obj.withMedia)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewFilterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
