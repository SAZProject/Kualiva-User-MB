// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fnb_recommended_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FnbRecommendedPageAdapter extends TypeAdapter<FnbRecommendedPage> {
  @override
  final int typeId = 25;

  @override
  FnbRecommendedPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FnbRecommendedPage(
      data: (fields[0] as List).cast<FnbRecommendedModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, FnbRecommendedPage obj) {
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
      other is FnbRecommendedPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
