// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fnb_promo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FnbPromoModelAdapter extends TypeAdapter<FnbPromoModel> {
  @override
  final int typeId = 22;

  @override
  FnbPromoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FnbPromoModel(
      id: fields[0] as String,
      name: fields[1] as String,
      promoPercentage: fields[2] as int,
      averageRating: fields[3] as double,
      cityOrVillage: fields[4] as String,
      categories: (fields[5] as List).cast<String>(),
      featuredImage: fields[6] as String?,
      distanceFromUser: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FnbPromoModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.promoPercentage)
      ..writeByte(3)
      ..write(obj.averageRating)
      ..writeByte(4)
      ..write(obj.cityOrVillage)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.featuredImage)
      ..writeByte(7)
      ..write(obj.distanceFromUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FnbPromoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
