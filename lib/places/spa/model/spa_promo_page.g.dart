// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spa_promo_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaPromoPageAdapter extends TypeAdapter<SpaPromoPage> {
  @override
  final int typeId = 31;

  @override
  SpaPromoPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpaPromoPage(
      data: (fields[0] as List).cast<SpaPromoModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, SpaPromoPage obj) {
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
      other is SpaPromoPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
