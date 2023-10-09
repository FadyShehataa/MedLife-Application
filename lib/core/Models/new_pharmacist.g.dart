// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_pharmacist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewPharmacistAdapter extends TypeAdapter<NewPharmacist> {
  @override
  final int typeId = 2;

  @override
  NewPharmacist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewPharmacist(
      name: fields[0] as String?,
      id: fields[1] as String?,
      email: fields[3] as String?,
      pharmacyId: fields[4] as String?,
      token: fields[5] as String?,
      pharmacyName: fields[6] as String?,
      pharmacyImage: fields[7] as String?,
    )
      ..lat = fields[8] as double?
      ..lng = fields[9] as double?;
  }

  @override
  void write(BinaryWriter writer, NewPharmacist obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.pharmacyId)
      ..writeByte(5)
      ..write(obj.token)
      ..writeByte(6)
      ..write(obj.pharmacyName)
      ..writeByte(7)
      ..write(obj.pharmacyImage)
      ..writeByte(8)
      ..write(obj.lat)
      ..writeByte(9)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewPharmacistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
