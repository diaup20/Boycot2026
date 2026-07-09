// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductHiveAdapter extends TypeAdapter<ProductHive> {
  @override
  final int typeId = 0;

  @override
  ProductHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductHive(
      id: fields[0] as int,
      name: fields[1] as String,
      barcode: fields[2] as String?,
      price: fields[3] as double?,
      category: (fields[9] as List).cast<CategoryModel>(),
      alternatives: (fields[10] as List).cast<AlternativeModel>(),
      violationReason: fields[14] as String?,
      brand: fields[11] as BrandModel?,
      agent: fields[12] as AgentModel?,
      isLocal: fields[4] as bool,
      isBoycott: fields[5] as bool,
      description: fields[6] as String?,
      unit: fields[7] as String?,
      image: fields[8] as String?,
      weight: fields[13] as String?,
      isViolent: fields[15] as bool?,
      isFav: fields[16] as bool?,
      isActive: fields[17] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductHive obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.barcode)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.isLocal)
      ..writeByte(5)
      ..write(obj.isBoycott)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.unit)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.category)
      ..writeByte(10)
      ..write(obj.alternatives)
      ..writeByte(11)
      ..write(obj.brand)
      ..writeByte(12)
      ..write(obj.agent)
      ..writeByte(13)
      ..write(obj.weight)
      ..writeByte(14)
      ..write(obj.violationReason)
      ..writeByte(15)
      ..write(obj.isViolent)
      ..writeByte(16)
      ..write(obj.isFav)
      ..writeByte(17)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
