// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParameterModelAdapter extends TypeAdapter<ParameterModel> {
  @override
  final int typeId = 10;

  @override
  ParameterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParameterModel(
      id: fields[0] as int,
      div: fields[1] as String,
      subDiv: fields[2] as String,
      languageCode: fields[3] as String,
      isActive: fields[4] as bool,
      explain: fields[5] as String,
      language: fields[7] as LanguageExplainModel,
      parameterDetails: (fields[8] as List).cast<ParameterDetailModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ParameterModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.div)
      ..writeByte(2)
      ..write(obj.subDiv)
      ..writeByte(3)
      ..write(obj.languageCode)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.explain)
      ..writeByte(7)
      ..write(obj.language)
      ..writeByte(8)
      ..write(obj.parameterDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParameterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
