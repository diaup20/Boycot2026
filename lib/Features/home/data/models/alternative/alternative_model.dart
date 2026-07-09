import 'package:hive/hive.dart';
import '../agent/agent_model.dart';
import '../brand_model.dart';
import '../category_model.dart';
import '../product_model.dart';

part 'alternative_model.g.dart';

@HiveType(typeId: 2)
class AlternativeModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? labelNumber;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final bool isLocal;
  @HiveField(5)
  final bool isBoycott;
  @HiveField(6)
  final int? unitId;
  @HiveField(7)
  final double? price;

  final int? categoryId;
  final int? brandId;
  final int? agentId;
  final String? unit;
  final String? description;
  final String? violationReason;
  final bool? isActive;
  final bool? isFav;
  final bool? isViolent;
  final String? barcode;
  final List<CategoryModel>? categories;
  final BrandModel? brand;
  final AgentModel? agent;

  AlternativeModel({
    required this.id,
    this.name,
    this.labelNumber,
    this.image,
    required this.isLocal,
    required this.isBoycott,
    this.unitId,
    this.price,
    this.categoryId,
    this.brandId,
    this.agentId,
    this.unit,
    this.description,
    this.violationReason,
    this.isActive,
    this.isFav,
    this.isViolent,
    this.barcode,
    this.categories,
    this.brand,
    this.agent,
  });

  factory AlternativeModel.fromJson(Map<String, dynamic> json) {
    bool parseBool(dynamic v) {
      if (v == null) return false;

      if (v is num) return v == 1;

      if (v is bool) return v;

      final s = v.toString().trim().toLowerCase();
      if (s == '1' || s == 'true' || s == 'نعم') return true;
      return false;
    }

    double? parsePrice(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }
    return AlternativeModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      labelNumber: json['label_number'] as String?,
      image: json['image'] as String?,
      isLocal: parseBool(json['is_local']),
      isBoycott: parseBool(json['is_boycott']),
      unitId: json['unit_id'] as int?,
      price: parsePrice(json['price']),
      categoryId: json['category_id'] as int?,
      brandId: json['brand_id'] as int?,
      agentId: json['agent_id'] as int?,
      unit: json['unit'] as String?,
      description: json['description'] as String?,
      violationReason: json['violation_reason'] as String?,
      isActive: json['is_active'] != null ? parseBool(json['is_active']) : null,
      isFav: json['is_fav'] != null ? parseBool(json['is_fav']) : null,
      isViolent:
          json['is_violant'] != null ? parseBool(json['is_violant']) : null,
      barcode: json['barcode'] as String?,
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : null,
      brand: json['brand'] != null ? BrandModel.fromJson(json['brand']) : null,
      agent: json['agent'] != null ? AgentModel.fromJson(json['agent']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'label_number': labelNumber,
        'image': image,
        'is_local': isLocal,
        'is_boycott': isBoycott,
        'unit_id': unitId,
        'price': price,
        'category_id': categoryId,
        'brand_id': brandId,
        'agent_id': agentId,
        'unit': unit,
        'description': description,
        'violation_reason': violationReason,
        'is_active': isActive,
        'is_fav': isFav,
        'is_violant': isViolent,
        'barcode': barcode,
        'categories': categories?.map((c) => c.toJson()).toList(),
        'brand': brand?.toJson(),
        'agent': agent?.toJson(),
      };

  ProductModel toProductModelFromParent(ProductModel parent) {
    return ProductModel(
      id: id,
      name: name ?? parent.name,
      image: parent.image, 
      isLocal: isLocal,
      isBoycott: isBoycott,
      unit: unit ?? parent.unit,
      price: price ?? parent.price,
      category: categories ?? parent.category,
      isActive: isActive ?? parent.isActive,
      isFav: isFav ?? parent.isFav,
      isViolent: isViolent ?? parent.isViolent,
      alternatives: const [],
      agent: agent ?? parent.agent,
      brand: brand ?? parent.brand,
      barcode: barcode ?? parent.barcode,
      violationReason: violationReason ?? parent.violationReason,
      description: description ?? parent.description,
    );
  }
}