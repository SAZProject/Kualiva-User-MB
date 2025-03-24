// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nightlife_recommended_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NightlifeRecommendedPageAdapter
    extends TypeAdapter<NightlifeRecommendedPage> {
  @override
  final int typeId = 29;

  @override
  NightlifeRecommendedPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NightlifeRecommendedPage(
      data: (fields[0] as List).cast<NightlifeRecommendedModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, NightlifeRecommendedPage obj) {
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
      other is NightlifeRecommendedPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
