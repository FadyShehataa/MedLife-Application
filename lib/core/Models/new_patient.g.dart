// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_patient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewPatientAdapter extends TypeAdapter<NewPatient> {
  @override
  final int typeId = 1;

  @override
  NewPatient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewPatient(
      name: fields[0] as String?,
      id: fields[1] as String?,
      imageURL: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      address: fields[4] as String?,
      token: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NewPatient obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imageURL)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewPatientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
