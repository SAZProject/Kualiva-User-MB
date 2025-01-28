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
      count: fields[1] as int?,
      isLikedByMe: fields[2] as bool?,
      description: fields[3] as String,
      rating: fields[4] as double,
      photoFiles: (fields[5] as List).cast<String>(),
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
      author: fields[8] as AuthorModel,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewPlaceModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.isLikedByMe)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.photoFiles)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
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
