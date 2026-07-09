// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppInfoHiveAdapter extends TypeAdapter<AppInfoHive> {
  @override
  final int typeId = 100;

  @override
  AppInfoHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppInfoHive(
      info: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppInfoHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.info);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppInfoHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
