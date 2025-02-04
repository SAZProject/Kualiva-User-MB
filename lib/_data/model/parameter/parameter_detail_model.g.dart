// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParameterDetailModelAdapter extends TypeAdapter<ParameterDetailModel> {
  @override
  final int typeId = 9;

  @override
  ParameterDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParameterDetailModel(
      id: fields[0] as int,
      parameterId: fields[1] as int,
      sequence: fields[2] as int,
      languageCode: fields[3] as String,
      isActive: fields[4] as bool,
      explain: fields[5] as String,
      image: fields[6] as String?,
      language: fields[7] as LanguageExplainModel,
    );
  }

  @override
  void write(BinaryWriter writer, ParameterDetailModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parameterId)
      ..writeByte(2)
      ..write(obj.sequence)
      ..writeByte(3)
      ..write(obj.languageCode)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.explain)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParameterDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
