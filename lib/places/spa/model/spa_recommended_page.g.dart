// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spa_recommended_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaRecommendedPageAdapter extends TypeAdapter<SpaRecommendedPage> {
  @override
  final int typeId = 33;

  @override
  SpaRecommendedPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpaRecommendedPage(
      data: (fields[0] as List).cast<SpaRecommendedModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, SpaRecommendedPage obj) {
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
      other is SpaRecommendedPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
