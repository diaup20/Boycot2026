
part of 'brand_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandModelAdapter extends TypeAdapter<BrandModel> {
  @override
  final int typeId = 3;

  @override
  BrandModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandModel(
      id: fields[0] as int,
      name: fields[1] as String,
      country: fields[2] as String?,
      companyName: fields[3] as String?,
      agent: fields[4] as AgentModel?,
      image: fields[5] as String?,
      isBoycott: fields[6] as bool,
      isLocal: fields[7] as bool,
      isActive: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BrandModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.companyName)
      ..writeByte(4)
      ..write(obj.agent)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.isBoycott)
      ..writeByte(7)
      ..write(obj.isLocal)
      ..writeByte(8)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
