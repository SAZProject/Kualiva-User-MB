// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nightlife_nearest_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NightlifeNearestPageAdapter extends TypeAdapter<NightlifeNearestPage> {
  @override
  final int typeId = 21;

  @override
  NightlifeNearestPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NightlifeNearestPage(
      data: (fields[0] as List).cast<NightlifeNearestModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, NightlifeNearestPage obj) {
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
      other is NightlifeNearestPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
