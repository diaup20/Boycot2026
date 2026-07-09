// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternative_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlternativeModelAdapter extends TypeAdapter<AlternativeModel> {
  @override
  final int typeId = 2;

  @override
  AlternativeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlternativeModel(
      id: fields[0] as int,
      name: fields[1] as String?,
      labelNumber: fields[2] as String?,
      image: fields[3] as String?,
      isLocal: fields[4] as bool,
      isBoycott: fields[5] as bool,
      unitId: fields[6] as int?,
      price: fields[7] as double?,
      categoryId: fields[8] as int?,
      brandId: fields[9] as int?,
      agentId: fields[10] as int?,
      unit: fields[11] as String?,
      description: fields[12] as String?,
      violationReason: fields[13] as String?,
      isActive: fields[14] as bool?,
      isFav: fields[15] as bool?,
      isViolent: fields[16] as bool?,
      barcode: fields[17] as String?,
      categories: fields[18] as List<CategoryModel>?,
      brand: fields[19] as BrandModel?,
      agent: fields[20] as AgentModel?,
    );
  }

  @override
  void write(BinaryWriter writer, AlternativeModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.labelNumber)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.isLocal)
      ..writeByte(5)
      ..write(obj.isBoycott)
      ..writeByte(6)
      ..write(obj.unitId)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.categoryId)
      ..writeByte(9)
      ..write(obj.brandId)
      ..writeByte(10)
      ..write(obj.agentId)
      ..writeByte(11)
      ..write(obj.unit)
      ..writeByte(12)
      ..write(obj.description)
      ..writeByte(13)
      ..write(obj.violationReason)
      ..writeByte(14)
      ..write(obj.isActive)
      ..writeByte(15)
      ..write(obj.isFav)
      ..writeByte(16)
      ..write(obj.isViolent)
      ..writeByte(17)
      ..write(obj.barcode)
      ..writeByte(18)
      ..write(obj.categories)
      ..writeByte(19)
      ..write(obj.brand)
      ..writeByte(20)
      ..write(obj.agent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlternativeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}