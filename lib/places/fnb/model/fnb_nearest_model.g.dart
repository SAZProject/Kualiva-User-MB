// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fnb_nearest_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FnbNearestModelAdapter extends TypeAdapter<FnbNearestModel> {
  @override
  final int typeId = 1;

  @override
  FnbNearestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FnbNearestModel(
      id: fields[0] as String,
      location: fields[1] as FnbNearestLocation,
      name: fields[2] as String,
      fullAddress: fields[3] as String,
      street: fields[4] as String,
      municipality: fields[5] as String,
      categories: (fields[6] as List).cast<String>(),
      timezone: fields[7] as String,
      phone: fields[8] as String?,
      phones: (fields[9] as List).cast<String>(),
      claimed: fields[10] as String,
      reviewCount: fields[11] as int,
      averageRating: fields[12] as double,
      reviewUrl: fields[13] as String?,
      googleMapsUrl: fields[14] as String,
      latitude: fields[15] as double,
      longitude: fields[16] as double,
      website: fields[17] as String?,
      openingHours: fields[18] as String?,
      featuredImage: fields[19] as String?,
      cid: fields[20] as String,
      fid: fields[21] as String,
      placeId: fields[22] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FnbNearestModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.fullAddress)
      ..writeByte(4)
      ..write(obj.street)
      ..writeByte(5)
      ..write(obj.municipality)
      ..writeByte(6)
      ..write(obj.categories)
      ..writeByte(7)
      ..write(obj.timezone)
      ..writeByte(8)
      ..write(obj.phone)
      ..writeByte(9)
      ..write(obj.phones)
      ..writeByte(10)
      ..write(obj.claimed)
      ..writeByte(11)
      ..write(obj.reviewCount)
      ..writeByte(12)
      ..write(obj.averageRating)
      ..writeByte(13)
      ..write(obj.reviewUrl)
      ..writeByte(14)
      ..write(obj.googleMapsUrl)
      ..writeByte(15)
      ..write(obj.latitude)
      ..writeByte(16)
      ..write(obj.longitude)
      ..writeByte(17)
      ..write(obj.website)
      ..writeByte(18)
      ..write(obj.openingHours)
      ..writeByte(19)
      ..write(obj.featuredImage)
      ..writeByte(20)
      ..write(obj.cid)
      ..writeByte(21)
      ..write(obj.fid)
      ..writeByte(22)
      ..write(obj.placeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FnbNearestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FnbNearestLocationAdapter extends TypeAdapter<FnbNearestLocation> {
  @override
  final int typeId = 0;

  @override
  FnbNearestLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FnbNearestLocation(
      type: fields[0] as String,
      coordinates: (fields[1] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, FnbNearestLocation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FnbNearestLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
