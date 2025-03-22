// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spa_nearest_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaNearestPageAdapter extends TypeAdapter<SpaNearestPage> {
  @override
  final int typeId = 19;

  @override
  SpaNearestPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpaNearestPage(
      data: (fields[0] as List).cast<SpaNearestModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, SpaNearestPage obj) {
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
      other is SpaNearestPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
