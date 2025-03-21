// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaginationAdapter extends TypeAdapter<Pagination> {
  @override
  final int typeId = 15;

  @override
  Pagination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pagination(
      size: fields[0] as int,
      totalCount: fields[1] as int,
      currentPage: fields[2] as int,
      previousPage: fields[3] as int?,
      nextPage: fields[4] as int?,
      totalPage: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pagination obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.size)
      ..writeByte(1)
      ..write(obj.totalCount)
      ..writeByte(2)
      ..write(obj.currentPage)
      ..writeByte(3)
      ..write(obj.previousPage)
      ..writeByte(4)
      ..write(obj.nextPage)
      ..writeByte(5)
      ..write(obj.totalPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
