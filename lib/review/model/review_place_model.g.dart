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
      invoice: fields[1] as String?,
      invoiceFile: fields[2] as String?,
      count: fields[3] as int?,
      isLikedByMe: fields[4] as bool?,
      description: fields[5] as String,
      rating: fields[6] as double,
      photoFiles: (fields[7] as List).cast<String>(),
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      author: fields[10] as AuthorModel,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewPlaceModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.invoice)
      ..writeByte(2)
      ..write(obj.invoiceFile)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.isLikedByMe)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.photoFiles)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
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
