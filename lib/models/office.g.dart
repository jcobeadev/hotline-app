// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfficeAdapter extends TypeAdapter<Office> {
  @override
  final int typeId = 0;

  @override
  Office read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Office(
      id: fields[0] as int?,
      name: fields[1] as String,
      mobile: (fields[2] as List?)?.cast<String>(),
      phone: (fields[3] as List?)?.cast<String>(),
      radio: fields[4] as String?,
      imageUrl: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Office obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.mobile)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.radio)
      ..writeByte(5)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
