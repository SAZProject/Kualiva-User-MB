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
      userCurrLoc: fields[0] as String,
      userCurrCity: fields[1] as String,
      userCurrSubDistrict: fields[3] as String,
      userFullPLacemark: fields[4] as Placemark,
      latitude: fields[5] as double,
      longitude: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentLocationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userCurrLoc)
      ..writeByte(1)
      ..write(obj.userCurrCity)
      ..writeByte(3)
      ..write(obj.userCurrSubDistrict)
      ..writeByte(4)
      ..write(obj.userFullPLacemark)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
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
