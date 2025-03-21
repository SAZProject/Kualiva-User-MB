// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentLocationModelAdapter extends TypeAdapter<CurrentLocationModel> {
  @override
  final int typeId = 2;

  @override
  CurrentLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentLocationModel(
      locationAddress: fields[0] as String,
      locality: fields[1] as String,
      subLocality: fields[2] as String,
      placemark: fields[3] as CurrentLocationPlacemarkModel,
      latitude: fields[4] as double,
      longitude: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentLocationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.locationAddress)
      ..writeByte(1)
      ..write(obj.locality)
      ..writeByte(2)
      ..write(obj.subLocality)
      ..writeByte(3)
      ..write(obj.placemark)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
