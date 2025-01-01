// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorModelAdapter extends TypeAdapter<AuthorModel> {
  @override
  final int typeId = 3;

  @override
  AuthorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthorModel(
      userId: fields[0] as String,
      username: fields[1] as String,
      photoFile: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthorModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.photoFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
