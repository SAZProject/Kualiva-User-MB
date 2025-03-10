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
      description: fields[0] as String?,
      selectedUser: fields[1] as ReviewSelectedUserEnum?,
      withMedia: fields[2] as bool?,
      rating: fields[3] as int?,
      order: fields[4] as ReviewOrderEnum?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewFilterModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.selectedUser)
      ..writeByte(2)
      ..write(obj.withMedia)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
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
