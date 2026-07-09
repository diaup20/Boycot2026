import 'agent/agent_model.dart';
import 'alternative/alternative_model.dart';
import 'brand_model.dart';
import 'category_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String? barcode;
  final double? price;
  final AgentModel? agent;
  final BrandModel? brand;
  final List<CategoryModel> category;
  final bool isLocal;
  final String? weight;
  final String? description;
  final String? violationReason;
  final bool isBoycott;
  final bool isActive;
  final bool isFav;
  final bool isViolent;
  final String? unit;
  final String? image;
  final List<AlternativeModel> alternatives;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    this.barcode,
    this.price,
    this.agent,
    this.brand,
    required this.category,
    required this.isLocal,
    this.weight,
    this.description,
    this.violationReason,
    required this.isBoycott,
    required this.isActive,
    required this.isFav,
    required this.isViolent,
    this.unit,
    this.image,
    required this.alternatives,
    this.createdAt,
    this.updatedAt,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'barcode': barcode,
        'price': price,
        'is_local': isLocal,
        'description': description,
        'unit': unit,
        'image': image,
        // نحول الـ category و alternatives أيضاً إلى JSON
        'category': category.map((c) => c.toJson()).toList(),
        'alternatives': alternatives.map((a) => a.toJson()).toList(),
        // إذا تريد تضمين agent/brand تحتاج toJson فيها أيضاً
      };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    bool parseBool(dynamic v) {
      if (v is bool) return v;
      final s = v?.toString().toLowerCase();
      return s == 'نعم' || s == '1' || s == 'true';
    }

    double? parseDouble(dynamic v) {
      if (v == null) return null;
      return double.tryParse(v.toString());
    }

    DateTime? parseDate(String? s) => s != null ? DateTime.tryParse(s) : null;

    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      barcode: json['barcode'] as String?,
      price: parseDouble(json['price']),
      agent: json['agent'] != null
          ? AgentModel.fromJson(json['agent'] as Map<String, dynamic>)
          : null,
      brand: json['brand'] != null
          ? BrandModel.fromJson(json['brand'] as Map<String, dynamic>)
          : null,
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isLocal: parseBool(json['is_local']),
      weight: json['weight'] as String?,
      description: json['description'] as String?,
      violationReason: json['violation_reason'] as String?,
      isBoycott: parseBool(json['is_boycott']),
      isActive: parseBool(json['is_active']),
      isFav: parseBool(json['is_fav']),
      isViolent: parseBool(json['is_violant']),
      unit: json['unit'] as String?,
      image: json['image'] as String?,
      alternatives: (json['alternatives'] as List<dynamic>?)
              ?.map((e) => AlternativeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: parseDate(json['created_at'] as String?),
      updatedAt: parseDate(json['updated_at'] as String?),
    );
  }
}
