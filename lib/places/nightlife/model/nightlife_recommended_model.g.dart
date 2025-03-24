// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nightlife_recommended_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NightlifeRecommendedModelAdapter
    extends TypeAdapter<NightlifeRecommendedModel> {
  @override
  final int typeId = 28;

  @override
  NightlifeRecommendedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NightlifeRecommendedModel(
      id: fields[0] as String,
      name: fields[1] as String,
      averageRating: fields[2] as double,
      fullAddress: fields[3] as String,
      cityOrVillage: fields[4] as String,
      categories: (fields[5] as List).cast<String>(),
      featuredImage: fields[6] as String?,
      isMerchant: fields[7] as bool,
      distanceFromUser: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NightlifeRecommendedModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.averageRating)
      ..writeByte(3)
      ..write(obj.fullAddress)
      ..writeByte(4)
      ..write(obj.cityOrVillage)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.featuredImage)
      ..writeByte(7)
      ..write(obj.isMerchant)
      ..writeByte(8)
      ..write(obj.distanceFromUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NightlifeRecommendedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
