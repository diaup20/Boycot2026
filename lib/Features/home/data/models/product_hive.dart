import 'package:hive/hive.dart';

import 'agent/agent_model.dart';
import 'alternative/alternative_model.dart';
import 'brand_model.dart';
import 'category_model.dart';
import 'product_model.dart';

part 'product_hive.g.dart';

@HiveType(typeId: 0)
class ProductHive {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? barcode;
  @HiveField(3)
  final double? price;
  @HiveField(4)
  final bool isLocal;
  @HiveField(5)
  final bool isBoycott;
  @HiveField(6)
  final String? description;
  @HiveField(7)
  final String? unit;
  @HiveField(8)
  final String? image;
  @HiveField(9)
  final List<CategoryModel> category;
  @HiveField(10)
  final List<AlternativeModel> alternatives;
  @HiveField(11)
  final BrandModel? brand;
  @HiveField(12)
  final AgentModel? agent;
  @HiveField(13)
  final String? weight;

  @HiveField(14)
  final String? violationReason;
  @HiveField(15)
  final bool? isViolent;
  @HiveField(16)
  final bool? isFav;
  @HiveField(17)
  final bool? isActive;


  ProductHive({
    required this.id,
    required this.name,
    this.barcode,
    this.price,
    required this.category,
    required this.alternatives,
    this.violationReason,
    this.brand,
    this.agent,
    required this.isLocal,
    required this.isBoycott,
    this.description,
    this.unit,
    this.image,
    this.weight,
    this.isViolent,
    this.isFav,
    this.isActive,
  });

  factory ProductHive.fromModel(ProductModel m) => ProductHive(
        id: m.id,
        name: m.name,
        barcode: m.barcode,
        price: m.price,
        isLocal: m.isLocal,
        isBoycott: m.isBoycott,
        description: m.description,
        unit: m.unit,
        image: m.image,
        category: m.category,
        alternatives: m.alternatives,
        agent: m.agent,
        brand: m.brand,
        violationReason: m.violationReason,
        weight: m.weight,
        isFav: m.isFav,
        isActive: m.isActive,
        isViolent: m.isViolent,
      );

  ProductModel toModel() => ProductModel(
        id: id, name: name,
        barcode: barcode, price: price,
        isLocal: isLocal, isBoycott: isBoycott,
        description: description, unit: unit, image: image,
        brand: brand, agent: agent, category: category, weight: weight,
        violationReason: violationReason, isActive: false, isFav: false,
        isViolent: isViolent ?? false, alternatives: alternatives,
        createdAt: null, updatedAt: null,
      );
}
