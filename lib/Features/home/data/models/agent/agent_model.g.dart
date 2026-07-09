// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgentModelAdapter extends TypeAdapter<AgentModel> {
  @override
  final int typeId = 4;

  @override
  AgentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgentModel(
      id: fields[0] as int,
      name: fields[1] as String,
      phone: fields[2] as String?,
      address: fields[3] as String?,
      isActive: fields[4] as bool,
      image: fields[5] as String?,
      brands: (fields[6] as List).cast<BrandModel>(),
      products: (fields[7] as List).cast<ProductModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AgentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.brands)
      ..writeByte(7)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
