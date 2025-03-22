// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fnb_nearest_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FnbNearestPageAdapter extends TypeAdapter<FnbNearestPage> {
  @override
  final int typeId = 17;

  @override
  FnbNearestPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FnbNearestPage(
      data: (fields[0] as List).cast<FnbNearestModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, FnbNearestPage obj) {
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
      other is FnbNearestPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
