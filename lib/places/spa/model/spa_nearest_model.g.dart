// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spa_nearest_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaNearestModelAdapter extends TypeAdapter<SpaNearestModel> {
  @override
  final int typeId = 18;

  @override
  SpaNearestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpaNearestModel(
      id: fields[0] as String,
      name: fields[1] as String,
      averageRating: fields[2] as double,
      fullAddress: fields[3] as String,
      categories: (fields[4] as List).cast<String>(),
      featuredImage: fields[5] as String?,
      isMerchant: fields[6] as bool,
      distanceFromUser: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SpaNearestModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.averageRating)
      ..writeByte(3)
      ..write(obj.fullAddress)
      ..writeByte(4)
      ..write(obj.categories)
      ..writeByte(5)
      ..write(obj.featuredImage)
      ..writeByte(6)
      ..write(obj.isMerchant)
      ..writeByte(7)
      ..write(obj.distanceFromUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaNearestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
