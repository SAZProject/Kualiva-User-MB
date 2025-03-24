// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nightlife_promo_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NightlifePromoPageAdapter extends TypeAdapter<NightlifePromoPage> {
  @override
  final int typeId = 27;

  @override
  NightlifePromoPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NightlifePromoPage(
      data: (fields[0] as List).cast<NightlifePromoModel>(),
      pagination: fields[1] as Pagination,
    );
  }

  @override
  void write(BinaryWriter writer, NightlifePromoPage obj) {
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
      other is NightlifePromoPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
