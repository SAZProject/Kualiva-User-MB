// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_place_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewPlacePageAdapter extends TypeAdapter<ReviewPlacePage> {
  @override
  final int typeId = 16;

  @override
  ReviewPlacePage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewPlacePage(
      data: (fields[0] as List).cast<ReviewPlaceModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewPlacePage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.pagination);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewPlacePageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
