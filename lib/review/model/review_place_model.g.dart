// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewPlaceModelAdapter extends TypeAdapter<ReviewPlaceModel> {
  @override
  final int typeId = 4;

  @override
  ReviewPlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewPlaceModel(
      id: fields[0] as int,
      description: fields[1] as String,
      rating: fields[2] as double,
      photoFiles: (fields[3] as List).cast<String>(),
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
      author: fields[6] as AuthorModel,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewPlaceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.photoFiles)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewPlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
