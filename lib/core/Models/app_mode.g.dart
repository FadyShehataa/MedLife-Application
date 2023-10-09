// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppModeAdapter extends TypeAdapter<AppMode> {
  @override
  final int typeId = 0;

  @override
  AppMode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppMode(
      userType: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppMode obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
