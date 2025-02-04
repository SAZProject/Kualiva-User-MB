// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_explain_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageExplainModelAdapter extends TypeAdapter<LanguageExplainModel> {
  @override
  final int typeId = 8;

  @override
  LanguageExplainModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageExplainModel(
      languageCode: fields[0] as String,
      en: fields[1] as String?,
      id: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageExplainModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.languageCode)
      ..writeByte(1)
      ..write(obj.en)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageExplainModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
