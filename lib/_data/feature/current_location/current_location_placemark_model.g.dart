// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_location_placemark_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentLocationPlacemarkModelAdapter
    extends TypeAdapter<CurrentLocationPlacemarkModel> {
  @override
  final int typeId = 7;

  @override
  CurrentLocationPlacemarkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentLocationPlacemarkModel(
      name: fields[0] as String?,
      street: fields[1] as String?,
      isoCountryCode: fields[2] as String?,
      country: fields[3] as String?,
      postalCode: fields[4] as String?,
      administrativeArea: fields[5] as String?,
      subAdministrativeArea: fields[6] as String?,
      locality: fields[7] as String?,
      subLocality: fields[8] as String?,
      thoroughfare: fields[9] as String?,
      subThoroughfare: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentLocationPlacemarkModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.street)
      ..writeByte(2)
      ..write(obj.isoCountryCode)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.postalCode)
      ..writeByte(5)
      ..write(obj.administrativeArea)
      ..writeByte(6)
      ..write(obj.subAdministrativeArea)
      ..writeByte(7)
      ..write(obj.locality)
      ..writeByte(8)
      ..write(obj.subLocality)
      ..writeByte(9)
      ..write(obj.thoroughfare)
      ..writeByte(10)
      ..write(obj.subThoroughfare);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentLocationPlacemarkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
